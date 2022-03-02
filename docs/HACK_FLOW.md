Hack Flow
=========


The production infra-strucuture needs can be briefly understood from the configuration file, that lives in the common library for all the GO code, including the validator, sequencer and more. But before diving deep on the code, I found in the version 0.8 of the arbitrum mono repo, a small instruction on how to start all the infra structure, with its respective scripts, that are described in the [deploy-guide](./DEPLOY_GUIDE.md) docs. Even using this guide, there are some pieces that were not connecting, so I granulated and tried to up every service as a stand-alone, compiling module by module.

## ARB-AVM

The first succesful compiled module was the C++ of the Arbitrum Virtual Machine. To run it, you have to clone this repo using the --recursive keyword, so all gitmodules will be downloaded. Maybe in an Ubuntu machine with all the libs it will compile, but for the sake of portability and reproducibility I added a [shell.nix](../validator/shell.nix) file with all the dependencies needed for it.


## L1-CONTRACTS

The L1 smart contracts were deployed in spark fuse, following the addresses bellow:



```

reusing "GasRefunder" at 0xA79C586B5F7d8E02CA2a8b8a9a997a6A48e71A70
"BridgeCreator" (tx: 0x5ea4314fe000ace1b398184f2e085ae1a7c81c6a8fb9a757c7862098f47c37b5)...: deployed at 0x4821C36C03E8d178e0cde67e5B46C55D46d38eb5 with 8150877 gas
"BridgeUtils" (tx: 0x326a7e84dc59cd2d6bd9760450aea68e5fa3aa144bba45e5b5862710b0a4f3e2)...: deployed at 0xc6ec791F3F9A83A88b01A8793eD3055aC3016DA6 with 243656 gas
 "NodeFactory" (tx: 0x767fa950e3f7f5eac6da22fef1793a0bf3abccb3f71401356e9932614a3b1b1c)...: deployed at 0x9eec69B1F15A2C7E85dfea46DD60aEa574d4bf15 with 1506810 gas
 "OneStepProof" (tx: 0x165812f59d1df12bea53bba30c95a2ce782119bfee371feb616778549fcd8ca0)...: deployed at 0xba82Fd5109EA4FD8D7e53839359A2135E3629c07 with 4648524 gas
 "OneStepProof2" (tx: 0x8d198811218598f04923cd56075c38fde9fb3eb0c7bd0231b87e78b5a75e0d60)...: deployed at 0x52A071B120F09aB058a848c29A55c6eaF16B1889 with 3641119 gas
 "OneStepProofHash" (tx: 0x3e46be8876ab309d226deef9598de7418feaadc2bdcc29b5fcc521fd1223bc62)...: deployed at 0xf22AC82AC9ed8abD41B3Cc3Ab643827Da26c04C9 with 3546699 gas
 "ValidatorUtils" (tx: 0x5fd3d79961f7667058104c0f4ea3a927364bb2db550fb3c8c7417b0084467135)...: deployed at 0xa766a6FD6e51F8AbDaB7B7Af7833225D53913DE1 with 2333338 gas
 "ValidatorWalletCreator" (tx: 0x887b910582e3ac35c36ef34750167389e1165b8fb5f32cb0bb1f460f024a5e54)...: deployed at 0x82070fc86B7609d3dD2b120d906D19B64D1b8D6B with 2496278 gas
reusing "Rollup" at 0xE6CDeDb4Acd04D0f467ff06863C97A77619DE226
reusing "RollupUserFacet" at 0x9A60A07fcfA3bf6acF93087D18E688EA92E4AA43
reusing "RollupAdminFacet" at 0xb13C024a3ddc7c0D903935c12E8F9ebfb53F7Fc7
 "ProxyAdmin" (tx: 0x57ac8710f4ac699843766cd7d0b27f3ca1c7d09db18cba35b4381dbb9fdc993c)...: deployed at 0x098d4BB756D04982f8baD8732f94fAdbEBdb598f with 549591 gas
 "TransparentUpgradeableProxy" (tx: 0x984ad602fe913ab1e129325b8bdd134c3372e76e1da7431aaf7717695828230e)...: deployed at 0x3410AdcE34b021b28662ac681773BE53B5454156 with 573533 gas
 "TransparentUpgradeableProxy" (tx: 0x18a6215071cf1723008165ef2ef0ea8d53f8ae612c6c88d61016360e59eb5861)...: deployed at 0xF3a0888a7d6A0769E58220d3132CE4A0616CE17A with 573533 gas
 "TransparentUpgradeableProxy" (tx: 0x3ba646e1ebef32cfe4d8297b9f5dcb8c024d95dfca89d537e30210abda9ff6f2)...: deployed at 0xc674399C6188cCB8e433a8b4B6d28ca0BA616104 with 573533 gas
 "ChallengeFactory" (tx: 0xa48b23aa46fc251e0eebde24e4f3c88b97be2683784a0fd3c48361b96e90ec01)...: deployed at 0x7a911C62e2229E5c0dc97d3ba991c908814c2F9F with 3068096 gas
 "RollupCreator" (tx: 0x41376f6b98e3c3b10da97a78bd826d68d347280442f88a9e4ce5f03fbd69081d)...: deployed at 0xEEf843d2A86EE6D746f4b79f8A8eECF5459e7FB7 with 2012728 gas
Done in 75.08s.

```


## ARB-UTIL


The [config](../validator/arb-util/configuration/configuration.go) contain the info about the sub-systems interactions:


```

"bridge-utils-address":             "0x84efa170dc6d521495d7942e372b8e4b2fb918ec",
"feed.input.url":                   []string{"wss://arb1.arbitrum.io/feed"},
"node.aggregator.inbox-address":    "0x4Dbd4fc535Ac27206064B68FfCf827b0A60BAB3f",
"node.chain-id":                    "42161",
"node.forwarder.target":            "https://arb1.arbitrum.io/rpc",
"persistent.chain":                 "mainnet",
"rollup.address":                   "0xC12BA48c781F6e392B49Db2E25Cd0c28cD77531A",
"rollup.from-block":                "12525700",
"rollup.machine.filename":          "mainnet.arb1.mexe",
"rollup.machine.url":               "https://raw.githubusercontent.com/OffchainLabs/arb-os/48bdb999a703575d26a856499e6eb3e17691e99d/arb_os/arbos.mexe",
"validator.utils-address":          "0x2B36F23ce0bAbD57553b26Da4C7a0585bac65DC1",
"validator.wallet-factory-address": "0xe17d8Fa6BC62590f840C5Dd35f300F77D55CC178",
```


I changed the config above to point to fuse-spark:

```
"bridge-utils-address":             "0xc6ec791F3F9A83A88b01A8793eD3055aC3016DA6",
"feed.input.url":                   []string{"wss://fuse-arb.fuse.io/feed"},
"node.aggregator.inbox-address":    "0x4Dbd4fc535Ac27206064B68FfCf827b0A60BAB3f",
"node.chain-id":                    "55123",
"node.forwarder.target":            "https://arb1.arbitrum.io/rpc",
"persistent.chain":                 "mainnet",
"rollup.address":                   "0xc674399C6188cCB8e433a8b4B6d28ca0BA616104",
"rollup.from-block":                "12525700",
"rollup.machine.filename":          "testnet.rinkeby.mexe",
"rollup.machine.url":               "https://raw.githubusercontent.com/OffchainLabs/arb-os/48bdb999a703575d26a856499e6eb3e17691e99d/arb_os/arbos.mexe",
"validator.utils-address":          "0xa766a6FD6e51F8AbDaB7B7Af7833225D53913DE1",
"validator.wallet-factory-address": "0x82070fc86B7609d3dD2b120d906D19B64D1b8D6B",

```


## SEQUENCER

When trying to run the validator using what I describe in the [forwarder](./FORWARDER.md) file,
I just noticed that we NEED a feed input url running... but what is this feed ?
So the first step is to check how the real one in the  wss://arb1.arbitrum.io/feed is running.

So using the [websocat](https://github.com/vi/websocat) tool, I just connected to the arbitrum feed and found the following data there:

```json
{
  "version": 1,
  "messages": [
    {
      "feedItem": {
        "batchItem": {
          "lastSequenceNumber": 19528372,
          "accumulator": [
            107,
            184,
            66,
            111,
            133,
            33,
            102,
            10,
            10,
            19,
            181,
            245,
            172,
            147,
            233,
            151,
            9,
            192,
            199,
            172,
            243,
            133,
            96,
            167,
            245,
            198,
            122,
            134,
            47,
            135,
            163,
            98
          ],
          "totalDelayedCount": 201371,
          "sequencerMessage": "A6YAChg3aqNYSgDqc4MNZJTFHwFhAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACbutIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYhNV+AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABKfq0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADggFIB/+CCkmD6vPMgwxjKZQ7YkNI/AaoYp4BB6ikCbg7YpfHe4Ax4PklAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAgIj1eBmL0Vd16dU0+C+oJCJHHdMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACDZ1SB2Je7WhQU6uZ7ytOLDTELYL3vn1NbFGOGNtcaH9aj9ahXxeWOSGekLYKPF5wIKL52fvxMkHGWnRWZ6RQvB7AA=="
        },
        "prevAcc": [
          242,
          126,
          214,
          191,
          113,
          137,
          24,
          247,
          212,
          25,
          96,
          83,
          62,
          82,
          221,
          156,
          141,
          127,
          36,
          203,
          252,
          52,
          103,
          6,
          194,
          90,
          18,
          84,
          126,
          18,
          217,
          217
        ]
      },
      "signature": "kJ7pqK3CsFr1geQw81RchMT8DtDDBM/Qk7UMxjWdV5NdMeHaUXf+JA5mOpVYSMRadSoQOznrpG8bNjeFmx+cNgA="
    },
    { ...
```


After searching in the files, the [sequencer](../validator/arb-rpc-node/cmd/arb-dev-sequencer/arb-dev-sequencer.go) was the best candidate, because it runs a web-socket server, and also points to the inbox code that generates the data structure above:

The actual data structure appears in the [sequencerBatchItem](../validator/arb-util/inbox/sequencerBatchItem.go) that lives in the [arb-util](../validator/arb-util) library, that is common for all the GO cmd executables.


```go
type SequencerBatchItem struct {
	LastSeqNum        *big.Int    `json:"lastSequenceNumber"`
	Accumulator       common.Hash `json:"accumulator"`
	TotalDelayedCount *big.Int    `json:"totalDelayedCount"`
	SequencerMessage  []byte      `json:"sequencerMessage"`
}
```


### Running the Sequencer

So when running the [sequencer](../validator/arb-rpc-node/cmd/arb-dev-sequencer/arb-dev-sequencer.go) and adding the three inputs requested there:

```
ROLLUP_CREATOR=0xEEf843d2A86EE6D746f4b79f8A8eECF5459e7FB7     	# Rollup creator address
BRIDGE=0xc6ec791F3F9A83A88b01A8793eD3055aC3016DA6  		          # Bridge Utils adddress
ETH_URL=https://rpc.fusespark.io

```

As you can see they are deployed in https://explorer.fusespark.io/, the first problem was the lack of Gas, that should be 1 Gwei (1+9 zeros), so after fixing it in the arb-dev-sequencer file around line 292:

```go
	transferTx := types.NewTx(&types.LegacyTx{
		Nonce:    nonce,
		GasPrice: big.NewInt(1000000000),
		Gas:      21000,
		To:       &seqAuth.From,
		Value:    transferSize,
		Data:     nil,
	})
```

It worked once, but still having back the issue....


#### log before fixing the gas

RollupCreator: 0xEEf843d2A86EE6D746f4b79f8A8eECF5459e7FB7

```json
{"level":"warn","component":"transactauth","stack":[{"func":"waitForReceiptWithResultsSimpleInternal","line":"120","source":"chain.go"},{"func":"WaitForReceiptWithResultsAndReplaceByFee","line":"224","source":"chain.go"},{"func":"WaitForReceiptWithResults","line":"250","source":"chain.go"},{"func":"startup","line":"214","source":"arb-dev-sequencer.go"},{"func":"main","line":"79","source":"arb-dev-sequencer.go"},{"func":"main","line":"225","source":"proc.go"},{"func":"goexit","line":"1371","source":"asm_amd64.s"}],"error":"receipt not found","tx":"f451631f5944020a0bfa5717feb4bd8920f401e831be0fd98ebbf23e32073a79","time":"2022-02-27T11:48:48+02:00","caller":"/home/henry/fuse-arb/validator/arb-util/transactauth/chain.go:226","message":"error while waiting for transaction receipt"}
{"component":"arb-node","time":"2022-02-27T11:48:48+02:00","caller":"/home/henry/fuse-arb/validator/arb-rpc-node/cmd/arb-dev-sequencer/arb-dev-sequencer.go:216","message":"Cleanly shutting down node"}
{"level":"error","component":"arb-node","stack":[{"func":"startup","line":"216","source":"arb-dev-sequencer.go"},{"func":"main","line":"79","source":"arb-dev-sequencer.go"},{"func":"main","line":"225","source":"proc.go"},{"func":"goexit","line":"1371","source":"asm_amd64.s"}],"error":"error getting transaction receipt: receipt not found","time":"2022-02-27T11:48:48+02:00","caller":"/home/henry/fuse-arb/validator/arb-rpc-node/cmd/arb-dev-sequencer/arb-dev-sequencer.go:80","message":"Error running node"}

```


Now, fixed the RollupCreator, but also had issues... note the chainid also not pointing to the chain:123 [that is the spark fuse chainid]

```
{"level":"info","component":"arb-node","chainaddress":"1d0decff9c3a5f6d3c5635411441b7502a14ab55","chainid":"68799","time":"2022-02-27T12:03:20+02:00","caller":"/home/henry/fuse-arb/validator/arb-rpc-node/cmd/arb-dev-sequencer/arb-dev-sequencer.go:232","message":"Launching arbitrum node"}
{"level":"info","component":"monitor","directory":"arbitrum102695120","time":"2022-02-27T12:03:21+02:00","caller":"/home/henry/fuse-arb/validator/arb-node-core/monitor/monitor.go:57","message":"database opened"}
Reloading chain to the last message saved
Initial machine load
{"level":"info","component":"monitor","time":"2022-02-27T12:03:21+02:00","caller":"/home/henry/fuse-arb/validator/arb-node-core/monitor/monitor.go:64","message":"storage initialized"}
{"level":"warn","component":"arb-node","stack":[{"func":"(*Monitor).StartInboxReader","line":"102","source":"monitor.go"},{"func":"startup","line":"254","source":"arb-dev-sequencer.go"},{"func":"main","line":"79","source":"arb-dev-sequencer.go"},{"func":"main","line":"225","source":"proc.go"},{"func":"goexit","line":"1371","source":"asm_amd64.s"}],"error":"error checking initial chain state: rollup not created","url":"https://rpc.fusespark.io","rollup":"0x1d0decff9c3a5f6d3c5635411441b7502a14ab55","bridgeUtils":"0xc6ec791f3f9a83a88b01a8793ed3055ac3016da6","time":"2022-02-27T12:03:21+02:00","caller":"/home/henry/fuse-arb/validator/arb-rpc-node/cmd/arb-dev-sequencer/arb-dev-sequencer.go:271","message":"failed to start inbox reader, waiting and retrying"}
{"level":"warn","component":"arb-node","stack":[{"func":"(*Monitor).StartInboxReader","line":"102","source":"monitor.go"},{"func":"startup","line":"254","source":"arb-dev-sequencer.go"},{"func":"main","line":"79","source":"arb-dev-sequencer.go"},{"func":"main","line":"225","source":"proc.go"},{"func":"goexit","line":"1371","source":"asm_amd64.s"}],"error":"error checking initial chain state: rollup not created","url":"https://rpc.fusespark.io","rollup":"0x1d0decff9c3a5f6d3c5635411441b7502a14ab55","bridgeUtils":"0xc6ec791f3f9a83a88b01a8793ed3055ac3016da6","time":"2022-02-27T12:03:26+02:00","caller":"/home/henry/fuse-arb/validator/arb-rpc-node/cmd/arb-dev-sequencer/arb-dev-sequencer.go:271","message":"failed to start inbox reader, waiting and retrying"}
^C{"level":"warn","component":"arb-node","stack":[{"func":"(*Monitor).StartInboxReader","line":"102","source":"monitor.go"},{"func":"startup","line":"254","source":"arb-dev-sequencer.go"},{"func":"main","line":"79","source":"arb-dev-sequencer.go"},{"func":"main","line":"225","source":"proc.go"},{"func":"goexit","line":"1371","source":"asm_amd64.s"}],"error":"error checking initial chain state: Post \"https://rpc.fusespark.io\": context canceled","url":"https://rpc.fusespark.io","rollup":"0x1d0decff9c3a5f6d3c5635411441b7502a14ab55","bridgeUtils":"0xc6ec791f3f9a83a88b01a8793ed3055ac3016da6","time":"2022-02-27T12:03:31+02:00","caller":"/home/henry/fuse-arb/validator/arb-rpc-node/cmd/arb-dev-sequencer/arb-dev-sequencer.go:271","message":"failed to start inbox reader, waiting and retrying"}

```



## Questions

* what is the data and why the sequencer calls the RollupCreator contract ?
* what are the next steps of sync the sequencer make ? i.e. what are all the necessary calls and its expected results to have the system running.
* why the aggregator connects to the sequencer ?
* what are the message traffic when a transaction acually happens in the arbitrum-os node ?


## Production Nodes Outputs


To run a production node as described in the [official](https://developer.offchainlabs.com/docs/running_node) documentation, we user the docker command below. As you can see, outputs for the arb-node executable. As you see, this doc starts only with the l1 address, so it runs as a forwarded node.



```
docker run --rm -it  -v ~/db/arbitrum-rinkeby/:/home/henry/.arbitrum/rinkeby \
	-p 0.0.0.0:8547:8547 \
	-p 0.0.0.0:8548:8548 \
	offchainlabs/arb-node:v1.2.0-9214e38 \
	--l1.url https://rinkeby.infura.io/v3/17509665a88549b9a5a5f8f3e291120c
{"level":"info","component":"configuration","l1url":"https://rinkeby.infura.io/v3/17509665a88549b9a5a5f8f3e291120c","chainid":"4","time":"2022-03-01T11:13:16Z","caller":"/home/user/arb-util/configuration/configuration.go:566","message":"connected to l1 chain"}
{"level":"info","component":"arb-node","chainaddress":"fe2c86cf40f89fe2f726cfbbacebae631300b50c","chainid":"066eeb","type":"forwarder","fromBlock":8700589,"time":"2022-03-01T11:13:16Z","caller":"/home/user/arb-rpc-node/cmd/arb-node/arb-node.go:195","message":"Launching arbitrum node"}
{"level":"info","component":"monitor","directory":"/home/user/.arbitrum/rinkeby/db","time":"2022-03-01T11:13:16Z","caller":"/home/user/arb-node-core/monitor/monitor.go:54","message":"database opened"}
Reloading chain starting with timestamp 1646131997
Seeding cache
{"level":"info","component":"monitor","time":"2022-03-01T11:13:17Z","caller":"/home/user/arb-node-core/monitor/monitor.go:61","message":"storage initialized"}
{"level":"info","component":"broadcaster","url":"wss://rinkeby.arbitrum.io/feed","time":"2022-03-01T11:13:17Z","caller":"/home/user/arb-util/broadcastclient/broadcastclient.go:115","message":"connecting to arbitrum inbox message broadcaster"}
{"level":"info","component":"arb-node","forwardTxURL":"https://rinkeby.arbitrum.io/rpc","time":"2022-03-01T11:13:17Z","caller":"/home/user/arb-rpc-node/cmd/arb-node/arb-node.go:266","message":"Arbitrum node starting in forwarder mode"}
{"level":"info","component":"broadcaster","time":"2022-03-01T11:13:18Z","caller":"/home/user/arb-util/broadcastclient/broadcastclient.go:130","message":"Connected"}
{"level":"info","component":"rpc","port":"8547","time":"2022-03-01T11:13:18Z","caller":"/home/user/arb-rpc-node/utils/rpc.go:100","message":"Launching rpc server over http"}
{"level":"info","component":"rpc","port":"8548","time":"2022-03-01T11:13:18Z","caller":"/home/user/arb-rpc-node/utils/rpc.go:100","message":"Launching websocket server over http"}
{"level":"info","component":"txdb","start":"0","count":1,"time":"2022-03-01T11:13:19Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"warn","component":"txdb","block":0,"time":"2022-03-01T11:13:19Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:298","message":"found empty block"}
{"level":"info","component":"txdb","start":"1","count":1,"time":"2022-03-01T11:13:19Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"warn","component":"txdb","block":1,"time":"2022-03-01T11:13:19Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:298","message":"found empty block"}
{"level":"info","component":"txdb","start":"2","count":1,"time":"2022-03-01T11:13:21Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"3","count":18,"time":"2022-03-01T11:13:21Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"21","count":2,"time":"2022-03-01T11:13:21Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"23","count":2,"time":"2022-03-01T11:13:21Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"25","count":2,"time":"2022-03-01T11:13:21Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"27","count":2,"time":"2022-03-01T11:13:22Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"29","count":4,"time":"2022-03-01T11:13:22Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"33","count":4,"time":"2022-03-01T11:13:22Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"37","count":8,"time":"2022-03-01T11:13:22Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"45","count":4,"time":"2022-03-01T11:13:22Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"49","count":4,"time":"2022-03-01T11:13:23Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"53","count":10,"time":"2022-03-01T11:13:23Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"warn","component":"txdb","hash":"4060c094759bd3dccdd9a2c253cf48652f6c2f368880c52c1a4571acd1e03ada","result":"","gas_used":944685,"gas_limit":1000000,"time":"2022-03-01T11:13:23Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:326","message":"tx reverted"}
{"level":"info","component":"txdb","start":"63","count":4,"time":"2022-03-01T11:13:23Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"warn","component":"txdb","hash":"00569388411cece76cd074ef9d2dd15c8f3b2a0531dd9b5d1a64d72efa987906","result":"","gas_used":944685,"gas_limit":1000000,"time":"2022-03-01T11:13:23Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:326","message":"tx reverted"}
{"level":"warn","component":"txdb","hash":"33a2f348dbc6b83930197c711e47224023a4f7e63dbd48bd9c3f49ec081bd0c6","result":"","gas_used":944685,"gas_limit":1000000,"time":"2022-03-01T11:13:23Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:326","message":"tx reverted"}
{"level":"info","component":"txdb","start":"67","count":1,"time":"2022-03-01T11:13:24Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"68","count":7,"time":"2022-03-01T11:13:24Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"75","count":17,"time":"2022-03-01T11:13:24Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"92","count":1,"time":"2022-03-01T11:13:27Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"93","count":2,"time":"2022-03-01T11:13:28Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"95","count":1,"time":"2022-03-01T11:13:34Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"96","count":2,"time":"2022-03-01T11:13:35Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"98","count":2,"time":"2022-03-01T11:13:35Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"100","count":2,"time":"2022-03-01T11:13:35Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"102","count":2,"time":"2022-03-01T11:13:35Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"104","count":10,"time":"2022-03-01T11:13:36Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"114","count":4,"time":"2022-03-01T11:13:36Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"118","count":2,"time":"2022-03-01T11:13:36Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"120","count":6,"time":"2022-03-01T11:13:36Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"126","count":2,"time":"2022-03-01T11:13:37Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"128","count":4,"time":"2022-03-01T11:13:37Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"132","count":6,"time":"2022-03-01T11:13:37Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"138","count":6,"time":"2022-03-01T11:13:37Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"144","count":4,"time":"2022-03-01T11:13:37Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"148","count":2,"time":"2022-03-01T11:13:38Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"150","count":10,"time":"2022-03-01T11:13:38Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"160","count":2,"time":"2022-03-01T11:13:38Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"162","count":4,"time":"2022-03-01T11:13:38Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"166","count":6,"time":"2022-03-01T11:13:38Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"172","count":4,"time":"2022-03-01T11:13:39Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"176","count":4,"time":"2022-03-01T11:13:39Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"180","count":6,"time":"2022-03-01T11:13:39Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"186","count":10,"time":"2022-03-01T11:13:39Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"196","count":4,"time":"2022-03-01T11:13:39Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"200","count":2,"time":"2022-03-01T11:13:40Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"202","count":6,"time":"2022-03-01T11:13:40Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"208","count":16,"time":"2022-03-01T11:13:40Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"warn","component":"txdb","hash":"1d74d66908625e7b96ad19f1f8d0535642b4d0259a206cc25581d89fb490f20f","result":"08c379a0000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000425472616e73706172656e745570677261646561626c6550726f78793a2061646d696e2063616e6e6f742066616c6c6261636b20746f2070726f787920746172676574000000000000000000000000000000000000000000000000000000000000","gas_used":1251,"gas_limit":8000000,"result_message":"TransparentUpgradeableProxy: admin cannot fallback to proxy target","time":"2022-03-01T11:13:40Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:326","message":"tx reverted"}
{"level":"warn","component":"txdb","hash":"c7092293bdff39f87bbbbe93304cdcb216f9677bb416c8b1e024c344026a0306","result":"08c379a0000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000425472616e73706172656e745570677261646561626c6550726f78793a2061646d696e2063616e6e6f742066616c6c6261636b20746f2070726f787920746172676574000000000000000000000000000000000000000000000000000000000000","gas_used":1243,"gas_limit":8000000,"result_message":"TransparentUpgradeableProxy: admin cannot fallback to proxy target","time":"2022-03-01T11:13:40Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:326","message":"tx reverted"}
{"level":"info","component":"txdb","start":"224","count":4,"time":"2022-03-01T11:13:40Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"warn","component":"txdb","hash":"0f0df71f9ea6f1c14484228957bd5be58a02207259c878b6ca8c78fdabfd73be","result":"08c379a0000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000425472616e73706172656e745570677261646561626c6550726f78793a2061646d696e2063616e6e6f742066616c6c6261636b20746f2070726f787920746172676574000000000000000000000000000000000000000000000000000000000000","gas_used":1275,"gas_limit":3000000,"result_message":"TransparentUpgradeableProxy: admin cannot fallback to proxy target","time":"2022-03-01T11:13:40Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:326","message":"tx reverted"}
{"level":"info","component":"txdb","start":"228","count":4,"time":"2022-03-01T11:13:40Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
Last checkpoint gas used: 1004378880, L1 block: 8722642, L2 block: 112
{"level":"info","component":"txdb","start":"232","count":6,"time":"2022-03-01T11:13:41Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"238","count":11,"time":"2022-03-01T11:13:41Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"warn","component":"txdb","hash":"03e2be2664547408046079bdc01ce0035c3d3a763b19567cdb8df91f58db393d","result":"08c379a0000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000425472616e73706172656e745570677261646561626c6550726f78793a2061646d696e2063616e6e6f742066616c6c6261636b20746f2070726f787920746172676574000000000000000000000000000000000000000000000000000000000000","gas_used":1251,"gas_limit":8000000,"result_message":"TransparentUpgradeableProxy: admin cannot fallback to proxy target","time":"2022-03-01T11:13:41Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:326","message":"tx reverted"}
{"level":"info","component":"txdb","start":"249","count":4,"time":"2022-03-01T11:13:41Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"253","count":4,"time":"2022-03-01T11:13:41Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"257","count":8,"time":"2022-03-01T11:13:41Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}

```


Mainet:

```
docker run --rm -it  -v ~/db/arbitrum-mainnet/:/home/henry/.arbitrum/mainnet \
	-p 0.0.0.0:8547:8547 \
	-p 0.0.0.0:8548:8548 \
	offchainlabs/arb-node:v1.2.0-9214e38 \
	--l1.url https://mainnet.infura.io/v3/17509665a88549b9a5a5f8f3e291120c
{"level":"info","component":"configuration","l1url":"https://mainnet.infura.io/v3/17509665a88549b9a5a5f8f3e291120c","chainid":"1","time":"2022-03-01T11:19:17Z","caller":"/home/user/arb-util/configuration/configuration.go:566","message":"connected to l1 chain"}
{"level":"info","component":"arb-node","chainaddress":"c12ba48c781f6e392b49db2e25cd0c28cd77531a","chainid":"a4b1","type":"forwarder","fromBlock":12525700,"time":"2022-03-01T11:19:17Z","caller":"/home/user/arb-rpc-node/cmd/arb-node/arb-node.go:195","message":"Launching arbitrum node"}
{"level":"info","component":"monitor","directory":"/home/user/.arbitrum/mainnet/db","time":"2022-03-01T11:19:18Z","caller":"/home/user/arb-node-core/monitor/monitor.go:54","message":"database opened"}
Reloading chain starting with timestamp 1646132358
Seeding cache
{"level":"info","component":"monitor","time":"2022-03-01T11:19:18Z","caller":"/home/user/arb-node-core/monitor/monitor.go:61","message":"storage initialized"}
{"level":"info","component":"broadcaster","url":"wss://arb1.arbitrum.io/feed","time":"2022-03-01T11:19:18Z","caller":"/home/user/arb-util/broadcastclient/broadcastclient.go:115","message":"connecting to arbitrum inbox message broadcaster"}
{"level":"info","component":"arb-node","forwardTxURL":"https://arb1.arbitrum.io/rpc","time":"2022-03-01T11:19:18Z","caller":"/home/user/arb-rpc-node/cmd/arb-node/arb-node.go:266","message":"Arbitrum node starting in forwarder mode"}
{"level":"info","component":"broadcaster","time":"2022-03-01T11:19:19Z","caller":"/home/user/arb-util/broadcastclient/broadcastclient.go:130","message":"Connected"}
{"level":"info","component":"rpc","port":"8547","time":"2022-03-01T11:19:19Z","caller":"/home/user/arb-rpc-node/utils/rpc.go:100","message":"Launching rpc server over http"}
{"level":"info","component":"rpc","port":"8548","time":"2022-03-01T11:19:19Z","caller":"/home/user/arb-rpc-node/utils/rpc.go:100","message":"Launching websocket server over http"}
{"level":"info","component":"txdb","start":"0","count":1,"time":"2022-03-01T11:19:20Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"warn","component":"txdb","block":0,"time":"2022-03-01T11:19:20Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:298","message":"found empty block"}
{"level":"info","component":"txdb","start":"1","count":1,"time":"2022-03-01T11:19:20Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"warn","component":"txdb","block":1,"time":"2022-03-01T11:19:20Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:298","message":"found empty block"}
{"level":"info","component":"txdb","start":"2","count":1,"time":"2022-03-01T11:19:21Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"3","count":8,"time":"2022-03-01T11:19:21Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"11","count":37,"time":"2022-03-01T11:19:21Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"48","count":1,"time":"2022-03-01T11:19:22Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"49","count":1,"time":"2022-03-01T11:19:22Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"50","count":1,"time":"2022-03-01T11:19:24Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"51","count":3,"time":"2022-03-01T11:19:24Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"54","count":1,"time":"2022-03-01T11:19:25Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"55","count":3,"time":"2022-03-01T11:19:25Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"58","count":1,"time":"2022-03-01T11:19:28Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"59","count":2,"time":"2022-03-01T11:19:28Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"61","count":2,"time":"2022-03-01T11:19:28Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"63","count":4,"time":"2022-03-01T11:19:28Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"67","count":2,"time":"2022-03-01T11:19:29Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"69","count":2,"time":"2022-03-01T11:19:29Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"71","count":31,"time":"2022-03-01T11:19:29Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"102","count":1,"time":"2022-03-01T11:19:29Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"103","count":3,"time":"2022-03-01T11:19:30Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"106","count":1,"time":"2022-03-01T11:19:30Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"107","count":19,"time":"2022-03-01T11:19:30Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"126","count":1,"time":"2022-03-01T11:19:31Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"127","count":1,"time":"2022-03-01T11:19:31Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"128","count":1,"time":"2022-03-01T11:19:31Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"129","count":5,"time":"2022-03-01T11:19:31Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"134","count":1,"time":"2022-03-01T11:19:32Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"135","count":1,"time":"2022-03-01T11:19:32Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"136","count":1,"time":"2022-03-01T11:19:32Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"137","count":2,"time":"2022-03-01T11:19:33Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"139","count":4,"time":"2022-03-01T11:19:33Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"143","count":2,"time":"2022-03-01T11:19:33Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"145","count":3,"time":"2022-03-01T11:19:33Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"148","count":1,"time":"2022-03-01T11:19:34Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"149","count":2,"time":"2022-03-01T11:19:34Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"warn","component":"txdb","block":76,"time":"2022-03-01T11:19:34Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:298","message":"found empty block"}
{"level":"info","component":"txdb","start":"151","count":1,"time":"2022-03-01T11:19:37Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"152","count":6,"time":"2022-03-01T11:19:37Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"158","count":6,"time":"2022-03-01T11:19:37Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"164","count":4,"time":"2022-03-01T11:19:38Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"168","count":8,"time":"2022-03-01T11:19:38Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"176","count":6,"time":"2022-03-01T11:19:38Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"182","count":2,"time":"2022-03-01T11:19:39Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"184","count":2,"time":"2022-03-01T11:19:39Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"186","count":11,"time":"2022-03-01T11:19:39Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"197","count":6,"time":"2022-03-01T11:19:39Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"warn","component":"txdb","block":100,"time":"2022-03-01T11:19:39Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:298","message":"found empty block"}
{"level":"info","component":"txdb","start":"203","count":4,"time":"2022-03-01T11:19:40Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"207","count":6,"time":"2022-03-01T11:19:40Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"213","count":8,"time":"2022-03-01T11:19:40Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"221","count":2,"time":"2022-03-01T11:19:40Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"223","count":6,"time":"2022-03-01T11:19:41Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"229","count":8,"time":"2022-03-01T11:19:41Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"237","count":4,"time":"2022-03-01T11:19:41Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"warn","component":"txdb","hash":"a3fefa25030cac6843fa05ea03b6005dd93933eeb09eacc58b9edd8f46cfbeef","result":"","gas_used":1091575,"gas_limit":6721975,"time":"2022-03-01T11:19:41Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:326","message":"tx reverted"}
{"level":"info","component":"txdb","start":"241","count":10,"time":"2022-03-01T11:19:41Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}
{"level":"info","component":"txdb","start":"251","count":2,"time":"2022-03-01T11:19:41Z","caller":"/home/user/arb-rpc-node/txdb/txdb.go:169","message":"adding logs"}

```



When running as a forwarder with fuse spark, we see that even this forwarder mode also needs the WS [websocket] broadcaster on...

```
o build -o bin/arb-node cmd/arb-node/arb-node.go
./bin/arb-node --l1.url=https://rpc.fusespark.io
{"level":"info","component":"configuration","l1url":"https://rpc.fusespark.io","chainid":"123","time":"2022-03-01T13:28:01+02:00","caller":"/home/henry/fuse-arb/validator/arb-util/configuration/configuration.go:597","message":"connected to l1 chain"}
{"level":"info","component":"arb-node","chainaddress":"c674399c6188ccb8e433a8b4b6d28ca0ba616104","chainid":"d753","type":"forwarder","fromBlock":12525700,"time":"2022-03-01T13:28:01+02:00","caller":"/home/henry/fuse-arb/validator/arb-rpc-node/cmd/arb-node/arb-node.go:199","message":"Launching arbitrum node"}
{"level":"info","component":"monitor","directory":"/home/henry/.arbitrum/mainnet/db","time":"2022-03-01T13:28:01+02:00","caller":"/home/henry/fuse-arb/validator/arb-node-core/monitor/monitor.go:57","message":"database opened"}
Reloading chain to the last message saved
Initial machine load
First database checkpoint,  total gas used: 28331570443, L1 block: 12691825, L2 block: 17636, log count: 36086, messages count: 35262, timestamp: Wed Jun 23 20:48:52 2021
First valid database checkpoint,  total gas used: 28331570443, L1 block: 12691825, L2 block: 17636, log count: 36086, messages count: 35262, timestamp: Wed Jun 23 20:48:52 2021
Loaded full machine,  total gas used: 28331570443, L1 block: 12691825, L2 block: 17636, log count: 36086, messages count: 35262, timestamp: Wed Jun 23 20:48:52 2021
Reorg took 2809ms
{"level":"info","component":"monitor","time":"2022-03-01T13:28:05+02:00","caller":"/home/henry/fuse-arb/validator/arb-node-core/monitor/monitor.go:64","message":"storage initialized"}
{"level":"info","component":"broadcaster","url":"wss://localhost/feed","time":"2022-03-01T13:28:05+02:00","caller":"/home/henry/fuse-arb/validator/arb-util/broadcastclient/broadcastclient.go:115","message":"connecting to arbitrum inbox message broadcaster"}
{"level":"warn","component":"broadcaster","error":"dial tcp [::1]:443: connect: connection refused","time":"2022-03-01T13:28:05+02:00","caller":"/home/henry/fuse-arb/validator/arb-util/broadcastclient/broadcastclient.go:122","message":"broadcast client unable to connect"}
{"level":"warn","component":"broadcaster","url":"wss://localhost/feed","error":"broadcast client unable to connect: dial tcp [::1]:443: connect: connection refused","time":"2022-03-01T13:28:05+02:00","caller":"/home/henry/fuse-arb/validator/arb-util/broadcastclient/broadcastclient.go:98","message":"failed connect to sequencer broadcast, waiting and retrying"}
{"level":"warn","component":"arb-node","stack":[{"func":"(*Monitor).StartInboxReader","line":"102","source":"monitor.go"},{"func":"startup","line":"240","source":"arb-node.go"},{"func":"main","line":"82","source":"arb-node.go"},{"func":"main","line":"225","source":"proc.go"},{"func":"goexit","line":"1371","source":"asm_amd64.s"}],"error":"error checking initial chain state: One of the blocks specified in filter (fromBlock, toBlock or blockHash) cannot be found","url":"https://rpc.fusespark.io","rollup":"0xc674399C6188cCB8e433a8b4B6d28ca0BA616104","bridgeUtils":"0xc6ec791F3F9A83A88b01A8793eD3055aC3016DA6","fromBlock":12525700,"time":"2022-03-01T13:28:05+02:00","caller":"/home/henry/fuse-arb/validator/arb-rpc-node/cmd/arb-node/arb-node.go:258","message":"failed to start inbox reader, waiting and retrying"}
{"level":"info","component":"broadcaster","url":"wss://localhost/feed","time":"2022-03-01T13:28:10+02:00","caller":"/home/henry/fuse-arb/validator/arb-util/broadcastclient/broadcastclient.go:115","message":"connecting to arbitrum inbox message broadcaster"}
{"level":"warn","component":"broadcaster","error":"dial tcp [::1]:443: connect: connection refused","time":"2022-03-01T13:28:10+02:00","caller":"/home/henry/fuse-arb/validator/arb-util/broadcastclient/broadcastclient.go:122","message":"broadcast client unable to connect"}

```


## Validator


there is an executable in the arb-node-core, called arb-validator,
trying to run it, got:

```
[nix-shell:~/fuse-arb/validator/arb-node-core]$ make run-validator 
./bin/arb-validator --l1.url=https://rpc.fusespark.io --feed.input.url=https:/rpc.fusespark.io:8546
{"level":"info","component":"configuration","l1url":"https://rpc.fusespark.io","chainid":"123","time":"2022-03-02T10:02:26+02:00","caller":"/home/henry/fuse-arb/validator/arb-util/configuration/configuration.go:597","message":"connected to l1 chain"}
{"level":"info","component":"cmdhelp","location":"/home/henry/.arbitrum/mainnet/validator-wallet","accounts":0,"time":"2022-03-02T10:02:27+02:00","caller":"/home/henry/fuse-arb/validator/arb-node-core/cmdhelp/wallet.go:169","message":"loading wallet"}
Enter new account password: {"level":"info","component":"cmdhelp","address":"0ab6697a64de6a49aa7f207f5b0033f922a7c5af","description":"account","time":"2022-03-02T10:02:43+02:00","caller":"/home/henry/fuse-arb/validator/arb-node-core/cmdhelp/wallet.go:205","message":"created new wallet"}
{"level":"info","component":"cmdhelp","signer":"0ab6697a64de6a49aa7f207f5b0033f922a7c5af","time":"2022-03-02T10:02:43+02:00","caller":"/home/henry/fuse-arb/validator/arb-node-core/cmdhelp/wallet.go:146","message":"wallet used as signer"}
{"level":"info","component":"arb-validator","address":"0x0Ab6697a64de6A49aA7f207f5b0033F922a7c5AF","time":"2022-03-02T10:02:43+02:00","caller":"/home/henry/fuse-arb/validator/arb-node-core/cmd/arb-validator/arb-validator.go:141","message":"Loaded wallet"}
{"level":"info","component":"monitor","directory":"/home/henry/.arbitrum/mainnet/validator-db","time":"2022-03-02T10:02:44+02:00","caller":"/home/henry/fuse-arb/validator/arb-node-core/monitor/monitor.go:57","message":"database opened"}
Reloading chain to the last message saved
Initial machine load
{"level":"info","component":"monitor","time":"2022-03-02T10:02:44+02:00","caller":"/home/henry/fuse-arb/validator/arb-node-core/monitor/monitor.go:64","message":"storage initialized"}
Aborting main ArbCore thread
Exiting main ArbCore thread
closing ArbStorage
closed ArbStorage
{"level":"info","component":"monitor","time":"2022-03-02T10:02:44+02:00","caller":"/home/henry/fuse-arb/validator/arb-node-core/monitor/monitor.go:83","message":"Database closed"}
{"component":"arb-validator","time":"2022-03-02T10:02:44+02:00","caller":"/home/henry/fuse-arb/validator/arb-node-core/cmd/arb-validator/arb-validator.go:211","message":"Cleanly shutting down validator"}
{"level":"error","component":"arb-validator","stack":[{"func":"startup","line":"211","source":"arb-validator.go"},{"func":"main","line":"74","source":"arb-validator.go"},{"func":"main","line":"225","source":"proc.go"},{"func":"goexit","line":"1371","source":"asm_amd64.s"}],"error":"error setting up staker: VM execution error.","time":"2022-03-02T10:02:44+02:00","caller":"/home/henry/fuse-arb/validator/arb-node-core/cmd/arb-validator/arb-validator.go:75","message":"Error running validator"}

```

I just created an account in the first time, and it saved in the ~/.arbritrum folder, so I added 0.5 Sparkfuse in the validator wallet: http://explorer.fusespark.io/address/0x0Ab6697a64de6A49aA7f207f5b0033F922a7c5AF/transactions 


The private key is:
{"address":"0ab6697a64de6a49aa7f207f5b0033f922a7c5af","crypto":{"cipher":"aes-128-ctr","ciphertext":"8254c802b8a5d8d8af01143f90b287ca63e9e5db31ba98c40ce7310e35f97980","cipherparams":{"iv":"bc51e245d3c742c7469ae0f505eab9e9"},"kdf":"scrypt","kdfparams":{"dklen":32,"n":262144,"p":1,"r":8,"salt":"813f77585b2e6798867ec1af44589e1e6c4d3bc77e17be998773ce55f42ebe61"},"mac":"b2f0ae1be3e44f6573bfbb81a13ed69dfaddddb45ed018c5df93708231109e0d"},"id":"3bd6f5f6-caf8-436b-9568-a097f0243536","version":3}

To use this wallet, the password is 'jim'


Tried again, and got a "loaded full machine !"

```
nix-shell:~/fuse-arb/validator/arb-node-core]$ make run-validator 
./bin/arb-validator --l1.url=https://rpc.fusespark.io --feed.input.url=https:/rpc.fusespark.io:8546
{"level":"info","component":"configuration","l1url":"https://rpc.fusespark.io","chainid":"123","time":"2022-03-02T10:09:36+02:00","caller":"/home/henry/fuse-arb/validator/arb-util/configuration/configuration.go:597","message":"connected to l1 chain"}
{"level":"info","component":"cmdhelp","location":"/home/henry/.arbitrum/mainnet/validator-wallet","accounts":1,"time":"2022-03-02T10:09:36+02:00","caller":"/home/henry/fuse-arb/validator/arb-node-core/cmdhelp/wallet.go:169","message":"loading wallet"}
Enter account password: {"level":"info","component":"cmdhelp","address":"0ab6697a64de6a49aa7f207f5b0033f922a7c5af","description":"account","time":"2022-03-02T10:11:03+02:00","caller":"/home/henry/fuse-arb/validator/arb-node-core/cmdhelp/wallet.go:205","message":"created new wallet"}
{"level":"info","component":"cmdhelp","signer":"0ab6697a64de6a49aa7f207f5b0033f922a7c5af","time":"2022-03-02T10:11:03+02:00","caller":"/home/henry/fuse-arb/validator/arb-node-core/cmdhelp/wallet.go:146","message":"wallet used as signer"}
{"level":"info","component":"arb-validator","address":"0x0Ab6697a64de6A49aA7f207f5b0033F922a7c5AF","time":"2022-03-02T10:11:03+02:00","caller":"/home/henry/fuse-arb/validator/arb-node-core/cmd/arb-validator/arb-validator.go:141","message":"Loaded wallet"}
{"level":"info","component":"monitor","directory":"/home/henry/.arbitrum/mainnet/validator-db","time":"2022-03-02T10:11:03+02:00","caller":"/home/henry/fuse-arb/validator/arb-node-core/monitor/monitor.go:57","message":"database opened"}
Reloading chain to the last message saved
Initial machine load
First database checkpoint,  total gas used: 0, L1 block: 0, L2 block: 0, log count: 0, messages count: 0, timestamp: Thu Jan  1 02:00:00 1970
First valid database checkpoint,  total gas used: 0, L1 block: 0, L2 block: 0, log count: 0, messages count: 0, timestamp: Thu Jan  1 02:00:00 1970
Loaded full machine,  total gas used: 0, L1 block: 0, L2 block: 0, log count: 0, messages count: 0, timestamp: Thu Jan  1 02:00:00 1970
Reorg took 16ms
{"level":"info","component":"monitor","time":"2022-03-02T10:11:04+02:00","caller":"/home/henry/fuse-arb/validator/arb-node-core/monitor/monitor.go:64","message":"storage initialized"}
Aborting main ArbCore thread
Exiting main ArbCore thread
closing ArbStorage
closed ArbStorage
{"level":"info","component":"monitor","time":"2022-03-02T10:11:04+02:00","caller":"/home/henry/fuse-arb/validator/arb-node-core/monitor/monitor.go:83","message":"Database closed"}
{"component":"arb-validator","time":"2022-03-02T10:11:04+02:00","caller":"/home/henry/fuse-arb/validator/arb-node-core/cmd/arb-validator/arb-validator.go:211","message":"Cleanly shutting down validator"}
{"level":"error","component":"arb-validator","stack":[{"func":"startup","line":"211","source":"arb-validator.go"},{"func":"main","line":"74","source":"arb-validator.go"},{"func":"main","line":"225","source":"proc.go"},{"func":"goexit","line":"1371","source":"asm_amd64.s"}],"error":"error setting up staker: VM execution error.","time":"2022-03-02T10:11:04+02:00","caller":"/home/henry/fuse-arb/validator/arb-node-core/cmd/arb-validator/arb-validator.go:75","message":"Error running validator"}

```


The error was at the end of the startup in the arbvalidator.go code, when trying to up the staker...


```
❯ grep -I -rn "NewStaker" .
./validator/arb-node-core/cmd/arb-validator/arb-validator.go:209:       stakerManager, _, err := staker.NewStaker(ctx, mon.Core, l1Client, val, config.Rollup.FromBlock, common.NewAddressFromEth(validatorUtilsAddr), strategy, bind.CallOpts{}, valAuth, config.Validator)
./validator/arb-node-core/staker/staker_test.go:224:    staker, _, err := NewStaker(ctx, mon.Core, client, val, rollupBlock.Int64(), common.NewAddressFromEth(validatorUtilsAddr), MakeNodesStrategy, bind.CallOpts{}, valAuth, configuration.Validator{})
./validator/arb-node-core/staker/staker_test.go:279:    faultyStaker, _, err := NewStaker(ctx, faultyCore, client, val2, rollupBlock.Int64(), common.NewAddressFromEth(validatorUtilsAddr), faultyStrategy, bind.CallOpts{}, val2Auth, configuration.Validator{})
./validator/arb-node-core/staker/staker.go:72:func NewStaker(

```

The staker is only up by using the arbvalidator command.

changing the gas to 1 gwei in the line 168



Created a broadcaster and connected to it: websocat ws://localhost:9642
with clean messages only, no data for this moment...
