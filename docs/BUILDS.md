Builds
======

I am documenting only successful build from the from package.json scripts in the repo's root.
A lot of trial/error was done before having this working sequence.

## Todo

- trace every call
- list artifacts results per call
- map artifact relashioships

## Results



```
"scripts": {
    ## SUCESS
    "install:deps": "./scripts/install-deps",
    "build": "yarn workspace arb-ts build",
    "install:validator": "./scripts/install-validator",
    "go:tidy": "./scripts/run-go-packages 'go mod tidy'",
    "go:generate": "./scripts/run-go-packages 'go generate ./...'",
    "go:vet": "./scripts/run-go-packages \"go list ./... | grep -v 'arb-node-core/ethbridge[^/]*contracts' | xargs go vet\"",
    "go:test": "./scripts/run-go-packages 'go test ./...'",
    "docker:build:geth": "yarn workspace arb-bridge-eth docker:build:geth",
    "docker:geth": "yarn workspace arb-bridge-eth docker:geth",

    ## STUCK
    "demo:initialize": "yarn workspace tools demo:initialize",

    ## PENDING
    "audit:ci": "audit-ci -l -a 1006805 1006806 1006865 1006896 1006899",
    "update:abi": "yarn go:generate && yarn workspace arb-ts update:abi",
    "docker:build:parity": "yarn workspace arb-bridge-eth docker:build:parity",
    "docker:build:ganache": "yarn workspace arb-bridge-eth docker:build:ganache",
    "run:local:geth": "yarn workspace arb-bridge-eth run:local:geth",
    "kill:geth": "kill $(lsof -t -i:7545)",
    "docker:parity": "yarn workspace arb-bridge-eth docker:parity",
    "docker:ganache": "yarn workspace arb-bridge-eth docker:ganache",
    "demo:deploy": "./scripts/arb_deploy.py local",
    "prod:initialize": "yarn workspace tools prod:initialize",
    "deploy:validators": "./scripts/arb_deploy.py"
  }
```

## yarn install deps

Worked well, and also when trying to reinstall, showed "requirement already satisfied"

## yarn run build

```
ubuntu@ip-172-31-11-183:~/arbitrum$ yarn run build
yarn run v1.22.17
$ yarn workspace arb-ts build
$ ./scripts/builder
Done in 9.72s.
```

## yarn run install:validator

```
ubuntu@ip-172-31-11-183:~/arbitrum$ yarn run install:validator
yarn run v1.22.17
$ ./scripts/install-validator
-- Submodule update
-- [cable ] Cable 0.5.0 initialized
-- Build type: Release
-- Found GMP: /usr/lib/x86_64-linux-gnu/libgmp.so
-- Found GMPXX: /usr/lib/x86_64-linux-gnu/libgmpxx.so
Boost 1.65 found.
Found Boost components:
   filesystem;system
-- Found rocksdb 6.20 in /usr/local/include;/usr/local/lib/librocksdb.so
-- clang-format found: /usr/bin/clang-format
-- cmake-format not found!
-- [hunter] Calculating Toolchain-SHA1
-- [hunter] Calculating Config-SHA1
-- [hunter] HUNTER_ROOT: /home/ubuntu/.hunter
-- [hunter] [ Hunter-ID: 1377523 | Toolchain-ID: 1720112 | Config-ID: 1f8c6e1 ]
-- [hunter] ETHASH_ROOT: /home/ubuntu/.hunter/_Base/1377523/1720112/1f8c6e1/Install (ver.: 0.5.0)
-- [hunter] INTX_ROOT: /home/ubuntu/.hunter/_Base/1377523/1720112/1f8c6e1/Install (ver.: 0.5.0)
-- GMP: /usr/lib/x86_64-linux-gnu/libgmp.so, /usr/include/x86_64-linux-gnu
-- Using the single-header code from /home/ubuntu/arbitrum/packages/arb-avm-cpp/external/json/single_include/
-- Found GMP: /usr/lib/x86_64-linux-gnu/libgmp.so
-- Found GMPXX: /usr/lib/x86_64-linux-gnu/libgmpxx.so
-- Configuring done
-- Generating done
-- Build files have been written to: /home/ubuntu/arbitrum/packages/arb-avm-cpp/build
[  7%] Built target secp256k1_ext
[ 10%] Built target zm
[ 21%] Built target avm_values
[ 48%] Built target ff
[ 55%] Built target avm
[ 61%] Built target cavm
[ 78%] Built target data_storage
[ 81%] Built target arbcore_runner
[ 83%] Built target avm_runner
[100%] Built target avm_tests
Done in 1.61s.
```


## yarn run go:tidy

```
ubuntu@ip-172-31-11-183:~/arbitrum$ yarn run go:tidy
yarn run v1.22.17
$ ./scripts/run-go-packages 'go mod tidy'
Done in 0.81s.
```

## yarn run go:generate

```
yarn run v1.22.17
$ ./scripts/run-go-packages 'go generate ./...'
Done in 4.84s.
```

## yarn run go:vet


```
ubuntu@ip-172-31-11-183:~/arbitrum$ yarn run go:vet
yarn run v1.22.17
$ ./scripts/run-go-packages "go list ./... | grep -v 'arb-node-core/ethbridge[^/]*contracts' | xargs go vet"
Done in 4.14s.
```

## yarn run go:test

```
buntu@ip-172-31-11-183:~/arbitrum$ yarn go:test
yarn run v1.22.17
$ ./scripts/run-go-packages 'go test ./...'
?   github.com/offchainlabs/arbitrum/packages/arb-util/arbtransaction[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-util/binding[no test files]
ok  github.com/offchainlabs/arbitrum/packages/arb-util/broadcastclient(cached)
ok  github.com/offchainlabs/arbitrum/packages/arb-util/broadcaster(cached)
?   github.com/offchainlabs/arbitrum/packages/arb-util/common[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-util/configuration[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-util/core[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-util/ethbridgecontracts[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-util/ethbridgetestcontracts[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-util/ethutils[no test files]
ok  github.com/offchainlabs/arbitrum/packages/arb-util/fireblocks(cached)
?   github.com/offchainlabs/arbitrum/packages/arb-util/fireblocks/accounttype[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-util/fireblocks/operationtype[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-util/hashing[no test files]
ok  github.com/offchainlabs/arbitrum/packages/arb-util/inbox(cached)
?   github.com/offchainlabs/arbitrum/packages/arb-util/machine[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-util/monitor[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-util/proofmachine[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-util/protocol[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-util/test[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-util/transactauth[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-util/value[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-util/wsbroadcastserver[no test files]
ok  github.com/offchainlabs/arbitrum/packages/arb-avm-cpp/cmachine0.812s
?   github.com/offchainlabs/arbitrum/packages/arb-avm-cpp/fuzz_target/proofchecker[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-avm-cpp/gotest[no test files]
ok  github.com/offchainlabs/arbitrum/packages/arb-avm-cpp/speedtest(cached) [no tests to run]
ok  github.com/offchainlabs/arbitrum/packages/arb-node-core/challenge(cached)
ok  github.com/offchainlabs/arbitrum/packages/arb-node-core/cmd/arb-relay(cached)
?   github.com/offchainlabs/arbitrum/packages/arb-node-core/cmd/arb-validator[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-node-core/cmd/proof-test-server[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-node-core/cmdhelp[no test files]
ok  github.com/offchainlabs/arbitrum/packages/arb-node-core/ethbridge(cached)
?   github.com/offchainlabs/arbitrum/packages/arb-node-core/metrics[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-node-core/monitor[no test files]
ok  github.com/offchainlabs/arbitrum/packages/arb-node-core/nodehealth(cached)
ok  github.com/offchainlabs/arbitrum/packages/arb-node-core/staker(cached)
?   github.com/offchainlabs/arbitrum/packages/arb-node-core/utils[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-rpc-node/aggregator[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-rpc-node/arbosmachine[no test files]
ok  github.com/offchainlabs/arbitrum/packages/arb-rpc-node/arbostest(cached)
?   github.com/offchainlabs/arbitrum/packages/arb-rpc-node/arbostestcontracts[no test files]
ok  github.com/offchainlabs/arbitrum/packages/arb-rpc-node/batcher(cached)
ok  github.com/offchainlabs/arbitrum/packages/arb-rpc-node/blockcache(cached)
?   github.com/offchainlabs/arbitrum/packages/arb-rpc-node/cmd/arb-cli[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-rpc-node/cmd/arb-dev-node[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-rpc-node/cmd/arb-dev-sequencer[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-rpc-node/cmd/arb-node[no test files]
ok  github.com/offchainlabs/arbitrum/packages/arb-rpc-node/dev(cached)
?   github.com/offchainlabs/arbitrum/packages/arb-rpc-node/rpc[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-rpc-node/snapshot[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-rpc-node/txdb[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-rpc-node/utils[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-rpc-node/web3[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-evm/arbos[no test files]
?   github.com/offchainlabs/arbitrum/packages/arb-evm/arboscontracts[no test files]
ok  github.com/offchainlabs/arbitrum/packages/arb-evm/evm(cached)
ok  github.com/offchainlabs/arbitrum/packages/arb-evm/message(cached)
Done in 4.53s.
```

## yarn run docker:build:geth

```
info Visit https://yarnpkg.com/en/docs/cli/run for documentation about this command.
ubuntu@ip-172-31-11-183:~/arbitrum$ yarn run docker:build:geth
yarn run v1.22.17
$ yarn workspace arb-bridge-eth docker:build:geth
$ docker build -t arb-bridge-eth-geth -f geth.Dockerfile .
Sending build context to Docker daemon  25.08MB
Step 1/7 : FROM ethereum/client-go:stable
 ---> 1bd5e07f4a10
Step 2/7 : RUN addgroup -g 1000 -S user &&     adduser -u 1000 -S user -G user -s /bin/ash -h /home/user
 ---> Using cache
 ---> a753f2819ffb
Step 3/7 : USER user
 ---> Using cache
 ---> 393efd6df1c4
Step 4/7 : WORKDIR /home/user/
 ---> Using cache
 ---> ecb5e6057def
Step 5/7 : COPY geth ./geth
 ---> Using cache
 ---> 1e67b78d2383
Step 6/7 : RUN echo arbitrum > password.txt &&     mkdir -p data/keystore &&     cp geth/keystore/* data/keystore &&     geth --datadir data init geth/ethbridge.json
 ---> Using cache
 ---> 4af426f9aa20
Step 7/7 : ENTRYPOINT ["/usr/local/bin/geth", "--syncmode", "full", "--datadir", "data", "--allow-insecure-unlock", "--unlock", "0x81183c9c61bdf79db7330bbcda47be30c0a85064"
, "--password", "/home/user/password.txt", "--mine"]
 ---> Using cache
 ---> 14639b5ee274
Successfully built 14639b5ee274
Successfully tagged arb-bridge-eth-geth:latest
Done in 0.81s.
```

## yarn run docker:geth

```
$ yarn workspace arb-bridge-eth docker:geth
$ rm -rf deployments/parity && ./scripts/launch-geth
9956e2339b8ca9a6e2ee4489ee39d2070a13482581afba15f285b29688e25c1e
Finished waiting for geth on localhost:7545...
$ $npm_execpath run hardhat:dev deploy --tags live --network local_development --export bridge_eth_addresses.json
$ hardhat --config hardhat.config.ts deploy --tags live --network local_development --export bridge_eth_addresses.json
No devnet privkey set
Compiling 83 files with 0.6.11
Compiling 4 files with 0.8.7
Generating typings for: 95 artifacts in dir: build/types for target: ethers-v5
Successfully generated 151 typings!
Compilation finished successfully

replacement fee too low (error={"name":"ProviderError","code":-32000,"_isProviderError":true}, method="sendTransaction", transaction=undefined, code=REPLACEMENT_UNDERPRICED
, version=providers/5.5.1) {"reason":"replacement fee too low","code":"REPLACEMENT_UNDERPRICED","error":{"name":"ProviderError","code":-32000,"_isProviderError":true},"meth
od":"sendTransaction"} Error: replacement fee too low (error={"name":"ProviderError","code":-32000,"_isProviderError":true}, method="sendTransaction", transaction=undefined
, code=REPLACEMENT_UNDERPRICED, version=providers/5.5.1)
    at Logger.makeError (/home/ubuntu/arbitrum/node_modules/@ethersproject/logger/src.ts/index.ts:225:28)
    at Logger.throwError (/home/ubuntu/arbitrum/node_modules/@ethersproject/logger/src.ts/index.ts:237:20)
    at checkError (/home/ubuntu/arbitrum/node_modules/@ethersproject/providers/src.ts/json-rpc-provider.ts:67:16)
    at /home/ubuntu/arbitrum/node_modules/@ethersproject/providers/src.ts/json-rpc-provider.ts:215:24
    at processTicksAndRejections (node:internal/process/task_queues:96:5) {
  reason: 'replacement fee too low',
  code: 'REPLACEMENT_UNDERPRICED',
  error: ProviderError: replacement transaction underpriced
      at HttpProvider.request (/home/ubuntu/arbitrum/node_modules/hardhat/src/internal/core/providers/http.ts:49:19)
      at GanacheGasMultiplierProvider.request (/home/ubuntu/arbitrum/node_modules/hardhat/src/internal/core/providers/gas-providers.ts:312:34)
      at processTicksAndRejections (node:internal/process/task_queues:96:5),
  method: 'sendTransaction',
  transaction: undefined
}
An unexpected error occurred:

Error: ERROR processing /home/ubuntu/arbitrum/packages/arb-bridge-eth/deploy/ValidatorUtils.ts:
Error: replacement fee too low (error={"name":"ProviderError","code":-32000,"_isProviderError":true}, method="sendTransaction", transaction=undefined, code=REPLACEMENT_UNDE
RPRICED, version=providers/5.5.1)
    at Logger.makeError (/home/ubuntu/arbitrum/node_modules/@ethersproject/logger/src.ts/index.ts:225:28)
    at Logger.throwError (/home/ubuntu/arbitrum/node_modules/@ethersproject/logger/src.ts/index.ts:237:20)
    at checkError (/home/ubuntu/arbitrum/node_modules/@ethersproject/providers/src.ts/json-rpc-provider.ts:67:16)
    at /home/ubuntu/arbitrum/node_modules/@ethersproject/providers/src.ts/json-rpc-provider.ts:215:24
    at processTicksAndRejections (node:internal/process/task_queues:96:5)
    at DeploymentsManager.executeDeployScripts (/home/ubuntu/arbitrum/node_modules/hardhat-deploy/src/DeploymentsManager.ts:1220:19)
    at processTicksAndRejections (node:internal/process/task_queues:96:5)
    at async DeploymentsManager.runDeploy (/home/ubuntu/arbitrum/node_modules/hardhat-deploy/src/DeploymentsManager.ts:1050:5)
    at async SimpleTaskDefinition.action (/home/ubuntu/arbitrum/node_modules/hardhat-deploy/src/index.ts:405:5)
    at async Environment._runTaskDefinition (/home/ubuntu/arbitrum/node_modules/hardhat/src/internal/core/runtime-environment.ts:217:14)
    at async Environment.run (/home/ubuntu/arbitrum/node_modules/hardhat/src/internal/core/runtime-environment.ts:129:14)
    at async SimpleTaskDefinition.action (/home/ubuntu/arbitrum/node_modules/hardhat-deploy/src/index.ts:551:32)
    at async Environment._runTaskDefinition (/home/ubuntu/arbitrum/node_modules/hardhat/src/internal/core/runtime-environment.ts:217:14)
    at async Environment.run (/home/ubuntu/arbitrum/node_modules/hardhat/src/internal/core/runtime-environment.ts:129:14)
    at async SimpleTaskDefinition.action (/home/ubuntu/arbitrum/node_modules/hardhat-deploy/src/index.ts:636:5)
error Command failed with exit code 1.
info Visit https://yarnpkg.com/en/docs/cli/run for documentation about this command.
error Command failed with exit code 1.
info Visit https://yarnpkg.com/en/docs/cli/run for documentation about this command.

INFO [02-11|09:48:38.001] Successfully sealed new block            number=47 sealhash=7af652..6ceb4c hash=24962a..cc2c0b elapsed=1.998s
INFO [02-11|09:48:38.001]  block reached canonical chain          number=40 hash=039dc5..8b2ea3
INFO [02-11|09:48:38.001]  mined potential block                  number=47 hash=24962a..cc2c0b
```

I runned again and got the same result [but didn't compile again]





## yarn demo:initialize [--validatorcount N=1]

```
ubuntu@ip-172-31-11-183:~/arbitrum$ yarn demo:initialize [--validatorcount N=1]
yarn run v1.22.17
$ yarn workspace tools demo:initialize [--validatorcount N=1]
$ ts-node ./scripts/setup_validators_demo.ts init [--validatorcount N=1]
/home/ubuntu/arbitrum/node_modules/ts-node/src/index.ts:750
    return new TSError(diagnosticText, diagnosticCodes);
           ^
TSError: ⨯ Unable to compile TypeScript:
scripts/setup_validators_demo.ts:9:28 - error TS2307: Cannot find module '../../arb-bridge-eth/bridge_eth_addresses.json' or its corresponding type declarations.

9 import * as addresses from '../../arb-bridge-eth/bridge_eth_addresses.json'
                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    at createTSError (/home/ubuntu/arbitrum/node_modules/ts-node/src/index.ts:750:12)
    at reportTSError (/home/ubuntu/arbitrum/node_modules/ts-node/src/index.ts:754:19)
    at getOutput (/home/ubuntu/arbitrum/node_modules/ts-node/src/index.ts:941:36)
    at Object.compile (/home/ubuntu/arbitrum/node_modules/ts-node/src/index.ts:1243:30)
    at Module.m._compile (/home/ubuntu/arbitrum/node_modules/ts-node/src/index.ts:1370:30)
    at Module._extensions..js (node:internal/modules/cjs/loader:1155:10)
    at Object.require.extensions.<computed> [as .ts] (/home/ubuntu/arbitrum/node_modules/ts-node/src/index.ts:1374:12)
    at Module.load (node:internal/modules/cjs/loader:981:32)
    at Function.Module._load (node:internal/modules/cjs/loader:822:12)
    at Function.executeUserEntryPoint [as runMain] (node:internal/modules/run_main:77:12) {
  diagnosticText: "\x1B[96mscripts/setup_validators_demo.ts\x1B[0m:\x1B[93m9\x1B[0m:\x1B[93m28\x1B[0m - \x1B[91merror\x1B[0m\x1B[90m TS2307: \x1B[0mCannot find module '../.
./arb-bridge-eth/bridge_eth_addresses.json' or its corresponding type declarations.\n" +
    '\n' +
    "\x1B[7m9\x1B[0m import * as addresses from '../../arb-bridge-eth/bridge_eth_addresses.json'\n" +
    '\x1B[7m \x1B[0m \x1B[91m                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\x1B[0m\n',
  diagnosticCodes: [ 2307 ]
}
error Command failed with exit code 1.
info Visit https://yarnpkg.com/en/docs/cli/run for documentation about this command.
error Command failed.
Exit code: 1
Command: /usr/local/bin/node
Arguments: /usr/share/yarn/lib/cli.js demo:initialize [--validatorcount N=1]
Directory: /home/ubuntu/arbitrum/packages/tools
Output:

info Visit https://yarnpkg.com/en/docs/cli/workspace for documentation about this command.
error Command failed with exit code 1.
info Visit https://yarnpkg.com/en/docs/cli/run for documentation about this command.
ubuntu@ip-172-31-11-183:~/arbitrum$ 
```


Found that bridge_eth_addresses.json is on the .gitignore

let's figure out how to generate it

Found, the Dockerfile says: Exports bridge_eth_addresses.json

when running docker build . , it complains that the buidler.config.ts was not found as:

```
Removing intermediate container 713f02ab710f
 ---> 346a3cc52258
Step 11/27 : COPY deploy ./deploy
 ---> 1ae6a0de74cc
Step 12/27 : COPY contracts ./contracts
 ---> 86df81bfcdca
Step 13/27 : COPY buidler.config.ts .
COPY failed: file not found in build context or excluded by .dockerignore: stat buidler.config.ts: file does not exis
```

so let's figure out how builder.config.ts works... but
when running yarn run docker:build:geth it works!, but why they created the Dockerfile with an old parity [2 years ago], 
and called it "geth" ? maybe smell code, let's see.


## Deploy Guide

If you follow the deploy guide [found in tag 0.8], there are 4 phases:


```bash
# arb-bridge-eth workspace
yarn docker:build:geth
yarn docker:geth

# tools workspace
yarn demo:initialize [--validatorcount N=1]   -> this phase needs the bridge_eth_addresses.json

# local python script
yarn demo:deploy
```

To create the bridge_eth_addresses.json you need to run the Dockerfile (that starts with 'parity') in the package
arb-bridge-eth .

when running the 'docker build -t arb-bridge-eth .' to create the .json file, it stops in an issue:

```
 ---> bddc200b2d75
Step 12/27 : COPY contracts ./contracts
 ---> f78620c6148f
Step 13/27 : COPY buidler.config.ts .
COPY failed: file not found in build context or excluded by .dockerignore: stat buidler.config.ts: file does not exist
```




