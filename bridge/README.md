# Bridge


## Steps

1. created a standard hardhat boilerplate
2. added the contracts from arbitrum
3. configured for multiple compilers


## Contracts Components


### Rollup:

This folder contains the contracts implemtnation the Arbitrum Optimistic Rollup. The core purpose of the Rollup is to advance the execution of the machine in order to eventually confirm assertions which will lead to withdrawals being processed.

Each Rollup chain has an associated `Bridge` which provides an interface for input and output between the Rollup chain and the L1.

The `RollupCreator` contract coordinates the deployment of an Arbitrum rollup chain including the setup of a proxy to enable upgradability by the owner of the chain. The owner is also able to perform a number of administrative functions without fully upgrading the chain like modifying the list of allowed inboxes and outboxes as well as rolling back the state of the chain.

### Bridge:

This folder contains the contracts implementing the Arbitrum Bridge which connects the L2 chain with the L1 chain. It's comprised of two major contract categories along with a core `Bridge` to coordinate them. Each Bridge has a set of connected inboxes and outboxes. The address of the `Bridge` serves as the rollups public address for making and receiving calls.

#### Inboxes

Each `Inbox` contract provides a mechanism for putting a message into the low level inbox maintained by the bridge. The `Inbox` is responsible for controlling what types of messages can be included, in some cases by maintaining L1 restrictions on who can send certain messages. The `Inbox` is also responsible for ensuring the data availability of the messages it delivers.

#### Outboxes

Each `Outbox` contract is able to send messages acting as the bridge contract, including controlling whatever Ether is held in the rollup chain. The standard `Outbox` receives commitments to trees of outgoing messages from the Rollup chain. Then users can redeem receipts in that tree in order to trigger the execution of the contained transaction with the `Bridge` as the sender.

### Challenge:

The `Challenge` contract is responsible for mediating disputes between conflicting stakers in the Rollup chain. In a challenge, one staker, the Asserter, is selected to defend a node that they created, and another staker, the Challenger, tries to prove that node is invalid. In the first phase of the challenge, the Challenger chooses a particular portion of the assertion that they disagree with. The Challenger should choose the first of this list that they can win.

- Inbox Consistency: The assertion claimed to read up to a given position in the inbox. This challenge assures that the end point is really a correct position in the inbox.
- Inbox Delta: The messages between the first read message and the last read message are accumulated into a hash which is proposed as part of the assertion. This challenge assures that the inbox delta was actually calculated correctly based on the messages read from the inbox.
- Execution Stopped Short: The portion of the assertion which specifies execution claimed to have executed a total amount of AvmGas. If the machine should have stopped before this point, this challenge can be used to propose a shorter assertion.
- Execution: This challenge can be used to ensure the correctness of the execution of the assertion.

### Arch

This folder contains contracts and libraries implementing AVM related logic. This mainly includes the one step execution prover contracts used by the execution challenge.

### Validator:

This contains two classes useful for being a validator

#### Validator - This is a simple smart contract wallet so that validators can call multiple rollup functions atomically

#### ValidatorUtils - This contract provides a number of helper methods that help the validator decide what actions to take

### Libraries:

This folder contains a bunch of libraries implementing various general functionality used by the rest of the codebase.

### Interfaces:

This folder contains interfaces to external libraries that are used by this package




## Tips

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
npx hardhat help
REPORT_GAS=true npx hardhat test
npx hardhat coverage
npx hardhat run scripts/deploy.ts
TS_NODE_FILES=true npx ts-node scripts/deploy.ts
npx eslint '**/*.{js,ts}'
npx eslint '**/*.{js,ts}' --fix
npx prettier '**/*.{json,sol,md}' --check
npx prettier '**/*.{json,sol,md}' --write
npx solhint 'contracts/**/*.sol'
npx solhint 'contracts/**/*.sol' --fix
```

# Etherscan verification

To try out Etherscan verification, you first need to deploy a contract to an Ethereum network that's supported by Etherscan, such as Ropsten.

In this project, copy the .env.example file to a file named .env, and then edit it to fill in the details. Enter your Etherscan API key, your Ropsten node URL (eg from Alchemy), and the private key of the account which will send the deployment transaction. With a valid .env file in place, first deploy your contract:

```shell
hardhat run --network ropsten scripts/sample-script.ts
```

Then, copy the deployment address and paste it in to replace `DEPLOYED_CONTRACT_ADDRESS` in this command:

```shell
npx hardhat verify --network ropsten DEPLOYED_CONTRACT_ADDRESS "Hello, Hardhat!"
```

# Performance optimizations

For faster runs of your tests and scripts, consider skipping ts-node's type checking by setting the environment variable `TS_NODE_TRANSPILE_ONLY` to `1` in hardhat's environment. For more details see [the documentation](https://hardhat.org/guides/typescript.html#performance-optimizations).
