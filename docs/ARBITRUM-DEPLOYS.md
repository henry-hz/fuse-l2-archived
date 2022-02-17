Arbitrum Deploys
================

Here is a list of addresses of actual arbitrum deployements, so we can monitor how transactions behave in production and in test environments.



It uses [proxy-pattern](https://docs.openzeppelin.com/upgrades-plugins/1.x/proxies) to upgrade implementations without changing the address call. Note that openzeppelin proxy is very abstract and can forward any call using the assembly code below. See [proxy-in-detail](https://blog.openzeppelin.com/proxy-patterns/) to check other proxy strategies.

```solidity
assembly {
  let ptr := mload(0x40)

  // (1) copy incoming call data
  calldatacopy(ptr, 0, calldatasize)

  // (2) forward call to logic contract
  let result := delegatecall(gas, _impl, ptr, calldatasize, 0, 0)
  let size := returndatasize

  // (3) retrieve return data
  returndatacopy(ptr, 0, size)

  // (4) forward return data back to caller
  switch result
  case 0 { revert(ptr, size) }
  default { return(ptr, size) }
}
```


## Rollup

Contracts implemtnation the Arbitrum Optimistic Rollup. The core purpose of the Rollup is to advance the execution of the machine in order to eventually confirm assertions which will lead to withdrawals being processed.

Each Rollup chain has an associated `Bridge` which provides an interface for input and output between the Rollup chain and the L1.

The `RollupCreator` contract coordinates the deployment of an Arbitrum rollup chain including the setup of a proxy to enable upgradability by the owner of the chain. The owner is also able to perform a number of administrative functions without fully upgrading the chain like modifying the list of allowed inboxes and outboxes as well as rolling back the state of the chain.


### Proxy

```
* Proxy:          0xC12BA48c781F6e392B49Db2E25Cd0c28cD77531A
* Implementation: 0x637E1CD58Ad3f0071ceCb281395e1823A96a553F
* Impl. Deploy:   0x862b38050a935092f3af04ef81d6a92838bd0eab2f13427ddd4fc890d91fbf02
* Commit Hash:    71eb134aa9be05e108d25ab0f9a7d4c62aacc0bd
```




### Mainnet Deployment

```
{
  "proxyAdminAddress": "0x171a2624302775eF943f4f62E76fd22A6813d7c4",
  "contracts": {
    "Rollup": {
      "proxyAddress": "0xC12BA48c781F6e392B49Db2E25Cd0c28cD77531A",
      "implAddress": "0x637E1CD58Ad3f0071ceCb281395e1823A96a553F",
      "implDeploymentTxn": "0x862b38050a935092f3af04ef81d6a92838bd0eab2f13427ddd4fc890d91fbf02",
      "implArbitrumCommitHash": "71eb134aa9be05e108d25ab0f9a7d4c62aacc0bd",
      "implBuildInfo": ""
    },
    "RollupAdminFacet": {
      "proxyAddress": "",
      "implAddress": "0x40Da6274A2E95D1b4baf2810700359ad258E6e21",
      "implDeploymentTxn": "0x07afefe93094f6e7f5a7257c0d41806ff6d23bb057360a2a53a134f60a7edf7e",
      "implArbitrumCommitHash": "71eb134aa9be05e108d25ab0f9a7d4c62aacc0bd",
      "implBuildInfo": ""
    },
    "RollupUserFacet": {
      "proxyAddress": "",
      "implAddress": "0x00c51f63a2d906510cb2c802c0a30589ba75d942",
      "implDeploymentTxn": "0x0382124d537fecbe8d17d5844c00e83d342d6c45fc90ed8b146225130d535275",
      "implArbitrumCommitHash": "71eb134aa9be05e108d25ab0f9a7d4c62aacc0bd",
      "implBuildInfo": ""
    },
    "RollupEventBridge": {
      "proxyAddress": "0xc8C3194eD3BE7B2393fEfE811a2Cc39297442c0B",
      "implAddress": "0xb872Ea300eDba3872873fa1Aa33DB897c4D2cB66",
      "implDeploymentTxn": "0x72f87e66cef89d1d2c4bda184e8d0af75b30599e3fd7ea5e4e438b14526c458d",
      "implArbitrumCommitHash": "71eb134aa9be05e108d25ab0f9a7d4c62aacc0bd",
      "implBuildInfo": ""
    },
    "Node": {
      "proxyAddress": "0x27A6cf5E8350b44273FB10F98D78525c5DAD6d8a",
      "implAddress": "0x118460018452a1E9f1f75Eaf8827D76B42f47E39",
      "implDeploymentTxn": "0x9e2828e5b24d956ca3ec3de8464565fa018e01dbd0e9d17adb541f5e530f89d3",
      "implArbitrumCommitHash": "71eb134aa9be05e108d25ab0f9a7d4c62aacc0bd",
      "implBuildInfo": ""
    },
    "Challenge": {
      "proxyAddress": "0x6AD1Dc4ab5475d9f8CD10118C9D28B06f0c8A2D9",
      "implAddress": "0x07945fa39E58F47EFfFcff62Ca616880d8D2df66",
      "implDeploymentTxn": "0x639622b299427a3d644c59f27284cad88ee36fc46fd4885e56d4a05b16124d47",
      "implArbitrumCommitHash": "71eb134aa9be05e108d25ab0f9a7d4c62aacc0bd",
      "implBuildInfo": ""
    },
    "OneStepProof": {
      "proxyAddress": "0x4812be53BE02b9F38063Cf55feF0a19d2Ba8bB3A",
      "implAddress": "0xb60923c12DC7846020645cc867EBe1E9D64aA8d9",
      "implDeploymentTxn": "0xd280aebb5bfece6925d02dc5b074036a0a23d28ec35ba09adb44f6a66848b3df",
      "implArbitrumCommitHash": "71eb134aa9be05e108d25ab0f9a7d4c62aacc0bd",
      "implBuildInfo": ""
    },
    "OneStepProof2": {
      "proxyAddress": "0x2DF287A3B2fd0916c0b3D4882201Ff360Acd6EC3",
      "implAddress": "0x0D20ea56bC505296481cAf4407badAa8E8107C7b",
      "implDeploymentTxn": "0xfa99f9ffb2e1a1f7739b49da064b4cfe8d43cfdf9f4548a4f455ce66c2dafc9b",
      "implArbitrumCommitHash": "71eb134aa9be05e108d25ab0f9a7d4c62aacc0bd",
      "implBuildInfo": ""
    },
    "OneStepProofHash": {
      "proxyAddress": "0xcE81E7d009e53c02242b724819df1869DA5e9FD8",
      "implAddress": "0xb4959b8d990A1BC3346F609109C3Aeb057979D61",
      "implDeploymentTxn": "0x1a78e1fd2d720748a06ba1b73cb401d0409d49ed17c388f2286570d88d6e8ee7",
      "implArbitrumCommitHash": "71eb134aa9be05e108d25ab0f9a7d4c62aacc0bd",
      "implBuildInfo": ""
    },
    "Inbox": {
      "proxyAddress": "0x4Dbd4fc535Ac27206064B68FfCf827b0A60BAB3f",
      "implAddress": "0x048cc108763de75E080Ad717bD284003aa49eA15",
      "implDeploymentTxn": "0xd4ef55c084c4fb0e8cabbaba6a5453a68149f85dcb3d90f95d92e8ec85138323",
      "implArbitrumCommitHash": "756db11bb41e35a8108cd70cb230f2bacbb2c998",
      "implBuildInfo": ""
    },
    "SequencerInbox": {
      "proxyAddress": "0x4c6f947Ae67F572afa4ae0730947DE7C874F95Ef",
      "implAddress": "0x9685e7281Fb1507B6f141758d80B08752faF0c43",
      "implDeploymentTxn": "0x51bea4c6ebbfd83ee5700404f9d9ab00c42e06df301bc9f2ddea027f1633e3a0",
      "implArbitrumCommitHash": "c49e68241bc9a25ac4c46d6f48676cc967424695",
      "implBuildInfo": ""
    },
    "Bridge": {
      "proxyAddress": "0x011B6E24FfB0B5f5fCc564cf4183C5BBBc96D515",
      "implAddress": "0x2f06e43D850Ac75926FA2866e40139475b58Cb16",
      "implDeploymentTxn": "0xeaac31d0cddabf94472c539028281944c35e007f1145e16575adcafd61d4c3fc",
      "implArbitrumCommitHash": "71eb134aa9be05e108d25ab0f9a7d4c62aacc0bd",
      "implBuildInfo": ""
    },
    "OldOutbox": {
      "proxyAddress": "0x667e23abd27e623c11d4cc00ca3ec4d0bd63337a",
      "implAddress": "0xb91f4bE773F5a1b9b0dC1085663b3535A6EBeEE2",
      "implDeploymentTxn": "0x7e0414ce05ff4cca53eda39d07195d7f3843c1f11a4e2705f5f96f4a42020df7",
      "implArbitrumCommitHash": "71eb134aa9be05e108d25ab0f9a7d4c62aacc0bd",
      "implBuildInfo": ""
    },
    "OutboxEntry": {
      "proxyAddress": "0x14797f5432f699Cb4d4dB04DF599B74952d78d7b",
      "implAddress": "0xc4940069140142236D4065b866018f7b2BeC77fD",
      "implDeploymentTxn": "0xd6dc4d8ed2cc893b3bb19f9b1be175e994aae4dd94710ca8e06030f91d7707a6",
      "implArbitrumCommitHash": "71eb134aa9be05e108d25ab0f9a7d4c62aacc0bd",
      "implBuildInfo": ""
    },
    "Outbox": {
      "proxyAddress": "0x760723CD2e632826c38Fef8CD438A4CC7E7E1A40",
      "implAddress": "0x8fdA3500EA1F8c6790cE5Ed482dA23337B3E2A5f",
      "implDeploymentTxn": "0x0a7fa5bc8e747b83cdbab256e71590bbc06376c5a8b4f31a7a455e5ec0544158",
      "implArbitrumCommitHash": "a69a1012c3d6f314537a713391050f0f7653494d",
      "implBuildInfo": ""
    }
  },
  "non-proxy-contracts": {
    "GasRefunder": {
      "address": "0x284c1875694058b213866f5f2ad015b5a4b9438b",
      "deploymentTxn": "0xac34d7dce8cd027246787f0097c7981c6c53e049d5d9e40bb1a32acd347cc3c6",
      "arbitrumCommitHash": "8d74aa48db7ccd639ed7998331f7428aef8d0afe",
      "implBuildInfo": ""
    }
  }
}
```





### Rinkeby Deployment


#### Rollup

- "proxyAdminAddress": "0x9F9Cf8CF09D4dB3D7B9b4527e96EB56e39A2a027",


- "proxyAddress": "0xFe2c86CF40F89Fe2F726cFBBACEBae631300b50c",
- https://rinkeby.etherscan.io/address/0xFe2c86CF40F89Fe2F726cFBBACEBae631300b50c
- 3/06/2021


* Current Implementation: 0x9D4FE81Ae3dc2E6F7D447aBF30ea0b010f4AB0B0",
  - https://rinkeby.etherscan.io/address/0x9D4FE81Ae3dc2E6F7D447aBF30ea0b010f4AB0B0
  - 28/08/2021

* ImplDeploymentTxn: "0xd1b3c11ea00180ed18f95cda4c41672585dbddbce680f2ffee777fac812adc11",
* ImplArbitrumCommitHash: "b034a588efe7b1b0801749e59de6226d5c12099a",

* Past Implementation: 0xf7c2cf5c146e11a3138b780a6f080ce5f3e4cdb9

```
{
  "contracts": {
    "Rollup": {
      "proxyAddress": "0xFe2c86CF40F89Fe2F726cFBBACEBae631300b50c",
      "implAddress": "0x9D4FE81Ae3dc2E6F7D447aBF30ea0b010f4AB0B0",
      "implDeploymentTxn": "0xd1b3c11ea00180ed18f95cda4c41672585dbddbce680f2ffee777fac812adc11",
      "implArbitrumCommitHash": "b034a588efe7b1b0801749e59de6226d5c12099a",
      "implBuildInfo": ""
    },
    "RollupAdminFacet": {
      "proxyAddress": "",
      "implAddress": "0xf0F615d647Accdb3e8Caf6c9B10723BB2FA888e3",
      "implDeploymentTxn": "0x6df0c54f58583e0f311177650e33f756fd1ba38e474ca703b6204d8e666c8aee",
      "implArbitrumCommitHash": "b034a588efe7b1b0801749e59de6226d5c12099a",
      "implBuildInfo": ""
    },
    "RollupUserFacet": {
      "proxyAddress": "",
      "implAddress": "0xb391A11CAeE4FACD5d99335b3bc9daD237cb855e",
      "implDeploymentTxn": "0xbefbb911dcc9dd1ebade5e2bf527c1ff931c453584b665a5174c8cc6a998f131",
      "implArbitrumCommitHash": "b034a588efe7b1b0801749e59de6226d5c12099a",
      "implBuildInfo": ""
    },
    "RollupEventBridge": {
      "proxyAddress": "0x935a635dc546f1d2fbe112a80b017575722823c7",
      "implAddress": "0x46Cb032DB29A361760dc882FE67f9DD76dd6ed76",
      "implDeploymentTxn": "0x1afc40e54acf0425c515f9308bd865734aecee42c9fa8e15a2754f307fe5cb69",
      "implArbitrumCommitHash": "b034a588efe7b1b0801749e59de6226d5c12099a",
      "implBuildInfo": ""
    },
    "Node": {
      "proxyAddress": "0xD8dF1Ec9cA786fc9a88d18B5B0e81fFB574dcc1d",
      "implAddress": "0xB5601be1587EA4A905fDeDa179fc24BF80C4916D",
      "implDeploymentTxn": "0x5151ce821c81860b06c99241369479cdcef344872d4b64869930c3cbd5a81ab8",
      "implArbitrumCommitHash": "b034a588efe7b1b0801749e59de6226d5c12099a",
      "implBuildInfo": ""
    },
    "Challenge": {
      "proxyAddress": "0x57094dcd1F928076FaEe852EDdb933997845A4e4",
      "implAddress": "0x30086459056b25cF7510e616b2B58592175F5eD5",
      "implDeploymentTxn": "0xb22c34f1afa9c0fbc9bbe5502036d128bd3ff0aec03e00103aa2238455778537",
      "implArbitrumCommitHash": "b034a588efe7b1b0801749e59de6226d5c12099a",
      "implBuildInfo": ""
    },
    "OneStepProof": {
      "proxyAddress": "0x6210a4eD13A487a5925EBe956b7a6E0b83325DA4",
      "implAddress": "0x99ee3a1891BCEea6738103E2442F0435dEa0AD7C",
      "implDeploymentTxn": "0x02fce98d6c4505c16cfbc695601c66a40d2d1e14c882822f8f77ffa8a4c2a6c1",
      "implArbitrumCommitHash": "b034a588efe7b1b0801749e59de6226d5c12099a",
      "implBuildInfo": ""
    },
    "OneStepProof2": {
      "proxyAddress": "0xb1F17484b93037d898b86E760fFA4B1E62445B8e",
      "implAddress": "0x626786aba9BC6464E8a56bc09ed0B938C589b52b",
      "implDeploymentTxn": "0x91695c8c659de1456950eb5e1b6b727e3e5aa3d4ec1b450fe164ace7a6a6f929",
      "implArbitrumCommitHash": "b034a588efe7b1b0801749e59de6226d5c12099a",
      "implBuildInfo": ""
    },
    "OneStepProofHash": {
      "proxyAddress": "0x0Cfb138F6Ca11D794907FA9cC01920EB93CBFF45",
      "implAddress": "0xDD77b98D4A6ED3f048132f5dAf5A6D80e9Bf0C8D",
      "implDeploymentTxn": "0x4c1983f9e6753cb4d11e26c15f5011f5c35dc9732d946149342679618a15c94d",
      "implArbitrumCommitHash": "b034a588efe7b1b0801749e59de6226d5c12099a",
      "implBuildInfo": ""
    },
    "Inbox": {
      "proxyAddress": "0x578BAde599406A8fE3d24Fd7f7211c0911F5B29e",
      "implAddress": "0x84ca6431C3E380A4a3967ef2dd86f64a1DF1054B",
      "implDeploymentTxn": "0x000a381f480a030bf0f8dc395dbe238b120c21a76c4a3a00a4fdf1a8987fd905",
      "implArbitrumCommitHash": "756db11bb41e35a8108cd70cb230f2bacbb2c998",
      "implBuildInfo": ""
    },
    "SequencerInbox": {
      "proxyAddress": "0xe1ae39e91c5505f7f0ffc9e2bbf1f6e1122dcfa8",
      "implAddress": "0x3C1C79C22A2A689a15Be2B931B348f3A93cD351F",
      "implDeploymentTxn": "0xc61887f3f6843182d6bf271bfc7c3a1454707ba4d1061be255d112df3896c142",
      "implArbitrumCommitHash": "56b134a930ca594ae5560962aab1140cb53415c3",
      "implBuildInfo": ""
    },
    "Bridge": {
      "proxyAddress": "0x9a28e783c47bbeb813f32b861a431d0776681e95",
      "implAddress": "0x8C79AD1D97962C82BCEaB7490286B6D04bf6F1F7",
      "implDeploymentTxn": "0xd96726efe7f7794d1b190b62a23c25578f5c0da4c0291b80a2f43f838ae8d30e",
      "implArbitrumCommitHash": "b034a588efe7b1b0801749e59de6226d5c12099a",
      "implBuildInfo": ""
    },
    "OldOutbox": {
      "proxyAddress": "0xefa1a42D3c4699822eE42677515A64b658be1bFc",
      "implAddress": "0x60287fE57B0d133b9F140867b37C267e42C056c2",
      "implDeploymentTxn": "0x6dcfee5a563ba8faea56ae6fc8a737611396d26d575cb220c3316a5c3de8e681",
      "implArbitrumCommitHash": "b034a588efe7b1b0801749e59de6226d5c12099a",
      "implBuildInfo": ""
    },
    "OutboxEntry": {
      "proxyAddress": "0x0a2f71f7c0174f32438c92fb0340e3e082b8320f",
      "implAddress": "0xCD5E48590b98F720f60B4e062fDd36ae4d22B843",
      "implDeploymentTxn": "0xda16c51f9d4c15252c5fed9b991361227f9d4fac68de1917e583b8716618cb11",
      "implArbitrumCommitHash": "b034a588efe7b1b0801749e59de6226d5c12099a",
      "implBuildInfo": ""
    },
    "Outbox": {
      "proxyAddress": "0x2360A33905dc1c72b12d975d975F42BaBdcef9F3",
      "implAddress": "0xB9c7b2127865964245c80bb4648aa2A6da36e89a",
      "implDeploymentTxn": "0x764010c767989b89478f97a91eed2f8e0a4e5bd607d98bcdec384d3bb0d8571a",
      "implArbitrumCommitHash": "a69a1012c3d6f314537a713391050f0f7653494d",
      "implBuildInfo": ""
    }
  },
  "non-proxy-contracts": {
    "GasRefunder": {
      "address": "0xBBeA02117225248de9ca68e5400794BF3f7F6a58",
      "deploymentTxn": "0x87be003b34ad9e41b4f81d30d788ea40a78c1ab57cf7c6891bf4ae1801c9647a",
      "arbitrumCommitHash": "8d74aa48db7ccd639ed7998331f7428aef8d0afe",
      "implBuildInfo": ""
    }
  }
}
```
