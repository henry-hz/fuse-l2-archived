Services Responsabilities
=========================

```
[ ] - deploy manually the deployment files in fuse L1
```


## Deployer


* deploy the hardhat sequence in the deploy folder
* start a server with the outputs.


The deployment.sh will run the hardhat with the following args:

```
npx hardhat deploy
"--network" "CONTRACTS_TARGET_NETWORK"
"--ovm-address-manager-owner" "OVM_ADDRESS_MANAGER_OWNER"
"--ovm-proposer-address" "OVM_PROPOSER_ADDRESS"
"--ovm-sequencer-address" "OVM_SEQUENCER_ADDRESS"
"--l1-block-time-seconds" "L1_BLOCK_TIME_SECONDS"
"--ctc-max-transaction-gas-limit" "CTC_MAX_TRANSACTION_GAS_LIMIT"
"--ctc-l2-gas-discount-divisor" "CTC_L2_GAS_DISCOUNT_DIVISOR"
"--ctc-enqueue-gas-cost" "CTC_ENQUEUE_GAS_COST"
"--scc-fraud-proof-window" "SCC_FRAUD_PROOF_WINDOW"
"--num-deploy-confirmations" "NUM_DEPLOY_CONFIRMATIONS"
"--forked" "FORKED"
```

> WORKDIR /opt/optimism/packages/contracts
> COPY ./ops/scripts/deployer.sh .

Deployment files on packages/contracts/deploy

```
000-hardhat-setup.ts
001-Lib_AddressManager.deploy.ts
002-OVM_ChainStorageContainer_ctc_batches.deploy.ts
003-OVM_ChainStorageContainer_scc_batches.deploy.ts
004-OVM_CanonicalTransactionChain.deploy.ts
005-OVM_StateCommitmentChain.deploy.ts
006-OVM_BondManager.deploy.ts
007-OVM_L1CrossDomainMessenger.deploy.ts
008-Proxy__OVM_L1CrossDomainMessenger.deploy.ts
009-Proxy__OVM_L1StandardBridge.deploy.ts
010-AddressDictator.deploy.ts
011-set-addresses.ts
012-initialize-Proxy__L1CrossDomainMessenger.ts
013-ChugSplashDictator.deploy.ts
014-OVM_L1StandardBridge.deploy.ts
015-finalize.ts
016-fund-accounts.ts
```


## Data Transport Layer

Typescript


## L2 node


## Relayer


## Verifier



## Replica



## Gas Oracle



## Batch Submitter
