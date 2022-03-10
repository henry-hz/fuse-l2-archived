Validator
=========

See Makefile to build and run the Docker.

This folder contains the Arbitrum L2 stuff in a compilable manner.

## Arb-avm

See the [readme](./arb-avm-cpp/README.md) file to compile it.


## Arb-OS

Contains the compiler. For convenience, use nix-shell se the nix-shell, but before, install nix package management. You will need nix for the C++ and also Go projects.

```
nix-shell
```

* https://unix.stackexchange.com/questions/190719/how-to-use-libraries-installed-by-nix-at-run-time


## Aggregator

An aggregator plays the same role that a node plays in Ethereum. Client software can do remote procedure calls (RPCs) to an aggregator, using the standard API, to interact with an Arbitrum chain. The aggregator will then make calls to the EthBridge and produce transactions results to the client, just an an Ethereum node would.




clone from: c678fae12f2a186cc9cf9b800f923e5ec37ae5f6 rev


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


* Fix gas for dev-sequencer

```
./bin/arb-dev-sequencer https://rpc.fusespark.io 0xEEf843d2A86EE6D746f4b79f8A8eECF5459e7FB7     	 0xc6ec791F3F9A83A88b01A8793eD3055aC3016DA6  	 
{"level":"warn","component":"transactauth","stack":[{"func":"waitForReceiptWithResultsSimpleInternal","line":"120","source":"chain.go"},{"func":"WaitForReceiptWithResultsAndReplaceByFee","line":"222","source":"chain.go"},{"func":"WaitForReceiptWithResults","line":"248","source":"chain.go"},{"func":"startup","line":"213","source":"arb-dev-sequencer.go"},{"func":"main","line":"79","source":"arb-dev-sequencer.go"},{"func":"main","line":"255","source":"proc.go"},{"func":"goexit","line":"1581","source":"asm_amd64.s"}],"error":"receipt not found","tx":"7a764fe9f6c3b0e153e5a71b46a613b38705af732cf1a69b5dde8d66e58d5be1","time":"2022-02-21T21:36:37Z","caller":"/home/ubuntu/fuse-arb/validator/arb-util/transactauth/chain.go:224","message":"error while waiting for transaction receipt"}
```
