Fuse Arbitrum Fork
==================


## Flow

```
L2 memory + storage + execution ---  send transaction--->  L1-inbox
                                |--- send transaction--->  Aggregator  ---- batch ---> L1-inbox 

```


## Aggregator

An aggregator plays the same role that a node plays in Ethereum. Client software can do remote procedure calls (RPCs) to an aggregator, using the standard API, to interact with an Arbitrum chain. The aggregator will then make calls to the EthBridge and produce transactions results to the client, just an an Ethereum node would.




clone from: c678fae12f2a186cc9cf9b800f923e5ec37ae5f6 rev

To clone and recursivelly clone all the submodules, use:

```
git clone --recurse-submodules git@github.com:henry-hz/fuse-arb.gi
```


## Bridge

L1 Bridge Smart Contracts



## Validator

L2 Virtual Machine + Arb-OS




## Tasks


> 1. deploy layer1 contracts 
> 2. Monitor production contracts and L2 to see a correctly working environment  
> 3. change L2 code to point to custome L1  
> 4. run custom L2  
> 5. monitor custom L2



## Resources


* [hardhat-deploy](https://levelup.gitconnected.com/deploying-smart-contracts-with-hardhat-e1a76212df94)
* [hardhat-template](https://github.com/wighawag/template-ethereum-contracts/)



## Tasks

Log analysis software will help, start analyzing a working node.

* Figure out how to run the ws [web-socket] server feed like the wss://arb1.arbitrum.io/feed or wss://rinkeby.arbitrum.io/feed . We are also looking for https://arb1.arbitrum.io/rpc 

* Yeah! found, analyzing the ws with 

```
→ websocat wss://rinkeby.arbitrum.io/feed > out                                                              [12efabf]
```

found the validator/arb-util/inbox/sequencerBatchItem.go , seems that the arb-rpc-node is using 

a private key was in arb-dev-sequencer.go

* just found they are using the https://github.com/gobwas/ws  (grep -inr --include \*.mod ws)

