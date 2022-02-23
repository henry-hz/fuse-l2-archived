## Deploy Guide


---
id: Local_Blockchain
title: Running on Local Blockchain
sidebar_label: Local Blockchain
---

## Launching a Local Blockchain

To build a docker image hosting a local test blockchain docker image with Arbitrum smart contracts already deployed, run:

```bash
## RUN
yarn docker:build:geth

## EFFECT
docker build -t arb-bridge-eth-geth -f geth.Dockerfile .

## FILE [geth.Dockerfile]
FROM ethereum/client-go:stable
RUN addgroup -g 1000 -S user && \
    adduser -u 1000 -S user -G user -s /bin/ash -h /home/user
USER user
WORKDIR /home/user/
COPY geth ./geth
RUN echo arbitrum > password.txt && \
    mkdir -p data/keystore && \
    cp geth/keystore/* data/keystore && \
    geth --datadir data init geth/ethbridge.json
ENTRYPOINT ["/usr/local/bin/geth", "--syncmode", "full", "--datadir", "data", "--allow-insecure-unlock", "--unlock", "0x81183c9c61bdf79db7330bbcda47be30c0a85064", "--password", "/home/user/password.txt", "--mine"]

```

To start the local blockchain inside the Arbitrum monorepo, run:

```bash
## RUN
yarn docker:geth

## EFFECT
rm -rf deployments/parity && ./scripts/launch-geth    # on arb-bridge-eth

## FILE [launch-geth]
docker network inspect arb-network >/dev/null 2>&1 || \
    docker network create --driver bridge arb-network
docker run -d -it --rm -p 7545:7545 -p 7546:7546 \
       --network=arb-network --name arb-bridge-eth-geth arb-bridge-eth-geth \
       --networkid=44010 \
       --http --http.addr 0.0.0.0 --http.port 7545 --http.corsdomain="*" --http.vhosts="*" \
       --http.api 'personal,db,eth,net,web3,txpool,miner' \
       --ws --ws.addr 0.0.0.0 --ws.port 7546 --ws.origins '*' \
       --ws.api personal,admin,db,eth,net,web3,miner,shh,txpool,debug \
       --gcmode=archive \
       --rpc.allow-unprotected-txs
while ! nc -z localhost 7545; do sleep 2; done;
echo "Finished waiting for geth on localhost:7545..."
rm -rf deployments/local_development
yarn deploy:live --network local_development --export bridge_eth_addresses.json && [ -f bridge_eth_addresses.json ]
docker attach arb-bridge-eth-geth
```

Note that stopping and restarting the client will lose all blockchain state.

## Launching the chain

To set up a local rollup chain using the Arbitrum geth docker image with 1 or more validators, run the following from the root arbitrum repo.

```bash
## RUN
yarn demo:initialize [--validatorcount N=1]


## EFFECT
ts-node ./scripts/setup_validators_demo.ts init


## FILE [setup_validators_demo.ts]
import * as yargs from 'yargs'
import * as fs from 'fs-extra'

const root = '../../'
const rollupsPath = root + 'rollups/'

export interface Config {
  rollup_address: string
  inbox_address: string
  validator_utils_address: string
  validator_wallet_factory_address: string
  eth_url: string
  password?: string
  blocktime: number
}

export async function setupValidatorStates(
  count: number,
  folder: string,
  config: Config
): Promise<void> {
  if (count < 1) {
    throw Error('must create at least 1 validator')
  }
  if (!fs.existsSync(rollupsPath)) {
    fs.mkdirSync(rollupsPath)
  }

  const arbOSData = fs.readFileSync('../arb-os/arb_os/arbos.mexe', 'utf8')

  const rollupPath = rollupsPath + folder + '/'
  if (fs.existsSync(rollupPath)) {
    throw Error(`${rollupPath} folder already exists`)
  }

  fs.mkdirSync(rollupPath)
  for (let i = 0; i < count; i++) {
    const valPath = rollupPath + 'validator' + i + '/'
    fs.mkdirSync(valPath)
    fs.writeFileSync(valPath + 'config.json', JSON.stringify(config))
    fs.writeFileSync(valPath + 'arbos.mexe', arbOSData)
  }
}

if (require.main === module) {
  const argv = yargs.command(
    'init [rollup] [ethurl]',
    'initialize validators for the given rollup chain',
    yargsBuilder =>
      yargsBuilder
        .positional('rollup', {
          describe: 'address of the rollup chain',
          type: 'string',
          demandOption: true,
        })
        .positional('inbox', {
          describe: 'address of the rollup chain inbox',
          type: 'string',
          demandOption: true,
        })
        .positional('validatorutils', {
          describe: 'address of the validator utils contract',
          type: 'string',
          demandOption: true,
        })
        .positional('validatorwallet', {
          describe: 'address of the validator wallet creator contract',
          type: 'string',
          demandOption: true,
        })
        .positional('ethurl', {
          describe: 'url for ethereum node',
          type: 'string',
          demandOption: true,
        })
        .options({
          validatorcount: {
            description: 'number of validators to deploy',
            default: 1,
          },
          blocktime: {
            description: 'expected length of time between blocks',
            default: 2,
          },
        }),
    args => {
      if (!args.rollup || !args.ethurl) {
        console.error('Must supply rollup address and eth url')
        return
      }
      const config: Config = {
        rollup_address: args.rollup,
        inbox_address: args.inbox,
        validator_utils_address: args.validatorutils,
        validator_wallet_factory_address: args.validatorwallet,
        eth_url: args.ethurl,
        blocktime: args.blocktime,
      }

      setupValidatorStates(
        args.validatorcount + 1,
        config.rollup_address,
        config
      )
    }
  ).argv
}
```

Running the `demo:initialize` command will perform two main tasks 
  1) Launch an Arbitrum Rollup chain on the local testnet 
  2) Create a `validator-states` folder. This folder contains pre-seeded wallets for the created validators which are prepared for launch. It serves as a lightweight simulation of an enviroment where the validators are running on multiple machines.


## Deploying your validators

To launch a set of docker images containing your validators, run:

```bash
## RUN
yarn demo:deploy

## EFFECT
./scripts/arb_deploy.py local


## FILE [arb_deploy.py]
import argparse
import os
import sys
import json

import build_node_docker
from support.run import run

# package configuration
NAME = "arb-deploy"
DESCRIPTION = "Manage Arbitrum dockerized deployments"

# filename constants
DOCKER_COMPOSE_FILENAME = "docker-compose.yml"

### ----------------------------------------------------------------------------
### docker-compose template
### ----------------------------------------------------------------------------

# Parameters: number of validators,
# absolute path to state folder, absolute path to contract
COMPOSE_HEADER = """# Machine generated by `arb-deploy`. Do not version control.
version: '3'
networks:
    default:
        external:
            name: arb-network
services:
    arb-node:
        volumes:
            - %s:/home/user/state
        image: arb-validator
        entrypoint: '/home/user/go/bin/arb-node'
        command: --sequencer %s state %s %s
        ports:
            - '1235:1235'
            - '8547:8547'
            - '8548:8548'
"""


def compose_header(state_abspath, extra_flags, rpc_url, rollup_address):
    return COMPOSE_HEADER % (state_abspath, extra_flags, rpc_url, rollup_address)


# Parameters: validator id, absolute path to state folder,
# absolute path to contract, validator id
COMPOSE_VALIDATOR = """
    arb-validator%d:
        volumes:
            - %s:/home/user/state
        image: arb-validator
        command: state %s %s %s %s %s %s
"""


# Returns one arb-validator declaration for a docker compose file
def compose_validator(
    validator_id,
    state_abspath,
    extra_flags,
    rpc_url,
    rollup_address,
    validator_utils_address,
    validator_wallet_factory_address,
    strategy,
):
    return COMPOSE_VALIDATOR % (
        validator_id,
        state_abspath,
        rpc_url,
        rollup_address,
        validator_utils_address,
        validator_wallet_factory_address,
        strategy,
        extra_flags,
    )


### ----------------------------------------------------------------------------
### Deploy
### ----------------------------------------------------------------------------


# Compile contracts to `contract.ao` and export to Docker and run validators
def deploy(sudo_flag, build_flag, up_flag, rollup, password):
    # Stop running Arbitrum containers
    halt_docker(sudo_flag)

    states_path = os.path.abspath(os.path.join("rollups", rollup, "validator%s"))

    n_validators = 1
    while True:
        if not os.path.exists(states_path % n_validators):
            break
        n_validators += 1

    # Overwrite DOCKER_COMPOSE_FILENAME

    compose = os.path.abspath("./" + DOCKER_COMPOSE_FILENAME)
    contents = ""
    for i in range(0, n_validators):
        with open(os.path.join(states_path % i, "config.json")) as json_file:
            data = json.load(json_file)
            rollup_address = data["rollup_address"]
            validator_utils_address = data["validator_utils_address"]
            validator_wallet_factory_address = data["validator_wallet_factory_address"]
            extra_flags = ""
            eth_url = (
                data["eth_url"]
                .replace("localhost", "arb-bridge-eth-geth")
                .replace("localhost", "arb-bridge-eth-geth")
            )

            if not password and "password" in data:
                extra_flags += " --password=" + data["password"]
            elif password:
                extra_flags += " --password=" + password
            else:
                raise Exception(
                    "arb_deploy requires validator password through [--password=pass] parameter or in config.json file"
                )
        if i == 0:
            contents = compose_header(
                states_path % 0, extra_flags, eth_url, rollup_address
            )
        else:
            strategy = "StakeLatest"
            if i == 1:
                strategy = "MakeNodes"
            contents += compose_validator(
                i,
                states_path % i,
                extra_flags,
                eth_url,
                rollup_address,
                validator_utils_address,
                validator_wallet_factory_address,
                strategy,
            )

    with open(compose, "w") as f:
        f.write(contents)

    # Build
    if not up_flag or build_flag:
        if build_node_docker.build_node(sudo_flag) != 0:
            exit(1)

    # Run
    if not build_flag or up_flag:
        print("Deploying", n_validators, "validators for rollup", rollup_address)
        run("docker-compose -f %s up" % compose, sudo=sudo_flag)


def halt_docker(sudo_flag):
    # Check for DOCKER_COMPOSE_FILENAME and halt if running
    if os.path.isfile("./" + DOCKER_COMPOSE_FILENAME):
        run(
            "docker-compose -f ./%s down -t 0" % DOCKER_COMPOSE_FILENAME,
            sudo=sudo_flag,
            capture_stdout=True,
        )

    # Kill and rm all docker containers and images created by any `arb-deploy`
    ps = "grep -e 'arb-validator' | awk '{ print $1 }'"
    if run("docker ps | " + ps, capture_stdout=True, quiet=True, sudo=sudo_flag) != "":
        run(
            "docker kill $("
            + ("sudo " if sudo_flag else "")
            + "docker ps | "
            + ps
            + ")",
            capture_stdout=True,
            sudo=sudo_flag,
        )
        run(
            "docker rm $("
            + ("sudo " if sudo_flag else "")
            + "docker ps -a | "
            + ps
            + ")",
            capture_stdout=True,
            sudo=sudo_flag,
        )


### ----------------------------------------------------------------------------
### Command line interface
### ----------------------------------------------------------------------------


def main():
    run("./scripts/create-network")

    parser = argparse.ArgumentParser(prog=NAME, description=DESCRIPTION)
    # Required
    parser.add_argument("rollup", type=str, help="The address of the rollup chain.")

    parser.add_argument("-p", "--password", help="Password protecting validator keys.")
    # Optional

    parser.add_argument(
        "-s",
        "--sudo",
        action="store_true",
        dest="sudo",
        help="Run docker-compose with sudo",
    )
    group = parser.add_mutually_exclusive_group()
    group.add_argument(
        "--build",
        action="store_true",
        dest="build",
        help="Run docker-compose build only",
    )
    group.add_argument(
        "--up", action="store_true", dest="up", help="Run docker-compose up only"
    )

    args = parser.parse_args()

    # Deploy
    deploy(args.sudo, args.build, args.up, args.rollup, args.password)


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        sys.exit(1)
```

Unlike the blockchain docker image, the validators can be stopped and restarted without losing any state.
