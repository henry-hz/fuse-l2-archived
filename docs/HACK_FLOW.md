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

When trying to run the validator using the command:

```

cd ./validator/arb-rpc-node
make build
./bin/arb-node --l1.url=https://mainnet.infura.io/v3/17509665a88549b9a5a5f8f3e291120c \
		--node.type=aggregator
```

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



## Questions

* what is the data and why the sequencer calls the RollupCreator contract ?
* what are the next steps of sync the sequencer make ?
* why the aggregator connects to the sequencer ?
* what are the message traffic when a transaction acually happens in the arbitrum-os node ?




