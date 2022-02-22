Forwarder
=========



We runned the forwarder connected to L1 eth mainet, and got:

```
./bin/arb-node --l1.url=https://mainnet.infura.io/v3/17509665a88549b9a5a5f8f3e291120c
{"level":"info","component":"configuration","l1url":"https://mainnet.infura.io/v3/17509665a88549b9a5a5f8f3e291120c","chainid":"1","time":"2022-02-22T15:02:57Z","caller":"/home/ubuntu/fuse-arb/validator/arb-util/configuration/configuration.go:597","message":"connected to l1 chain"}
{"level":"info","component":"arb-node","chainaddress":"c12ba48c781f6e392b49db2e25cd0c28cd77531a","chainid":"a4b1","type":"forwarder","fromBlock":12525700,"time":"2022-02-22T15:02:58Z","caller":"/home/ubuntu/fuse-arb/validator/arb-rpc-node/cmd/arb-node/arb-node.go:199","message":"Launching arbitrum node"}
{"level":"info","component":"monitor","directory":"/home/ubuntu/.arbitrum/mainnet/db","time":"2022-02-22T15:02:58Z","caller":"/home/ubuntu/fuse-arb/validator/arb-node-core/monitor/monitor.go:57","message":"database opened"}
Reloading chain to the last message saved
Initial machine load
{"level":"info","component":"monitor","time":"2022-02-22T15:02:58Z","caller":"/home/ubuntu/fuse-arb/validator/arb-node-core/monitor/monitor.go:64","message":"storage initialized"}
{"level":"info","component":"broadcaster","url":"wss://arb1.arbitrum.io/feed","time":"2022-02-22T15:02:58Z","caller":"/home/ubuntu/fuse-arb/validator/arb-util/broadcastclient/broadcastclient.go:115","message":"connecting to arbitrum inbox message broadcaster"}
{"level":"info","component":"arb-node","forwardTxURL":"https://arb1.arbitrum.io/rpc","time":"2022-02-22T15:02:58Z","caller":"/home/ubuntu/fuse-arb/validator/arb-rpc-node/cmd/arb-node/arb-node.go:270","message":"Arbitrum node starting in forwarder mode"}
{"level":"info","component":"txdb","l2Block":"0","l1Block":"0","timestamp":"1970-01-01T00:00:00Z","time":"2022-02-22T15:02:59Z","caller":"/home/ubuntu/fuse-arb/validator/arb-rpc-node/txdb/txdb.go:205","message":"sync update"}
{"level":"info","component":"broadcaster","time":"2022-02-22T15:02:59Z","caller":"/home/ubuntu/fuse-arb/validator/arb-util/broadcastclient/broadcastclient.go:130","message":"Connected"}
{"level":"info","component":"rpc","port":"8548","time":"2022-02-22T15:02:59Z","caller":"/home/ubuntu/fuse-arb/validator/arb-rpc-node/utils/rpc.go:100","message":"Launching websocket server over http"}
{"level":"info","component":"rpc","port":"8547","time":"2022-02-22T15:02:59Z","caller":"/home/ubuntu/fuse-arb/validator/arb-rpc-node/utils/rpc.go:100","message":"Launching rpc server over http"}
{"level":"info","component":"txdb","l2Block":"1","l1Block":"12525700","timestamp":"2021-05-28T23:09:04Z","time":"2022-02-22T15:02:59Z","caller":"/home/ubuntu/fuse-arb/validator/arb-rpc-node/txdb/txdb.go:205","message":"sync update"}
{"level":"info","component":"txdb","l2Block":"5","l1Block":"12526210","timestamp":"2021-05-29T01:07:22Z","time":"2022-02-22T15:03:00Z","caller":"/home/ubuntu/fuse-arb/validator/arb-rpc-node/txdb/txdb.go:205","message":"sync update"}
{"level":"info","component":"txdb","l2Block":"24","l1Block":"12526263","timestamp":"2021-05-29T01:19:55Z","time":"2022-02-22T15:03:01Z","caller":"/home/ubuntu/fuse-arb/validator/arb-rpc-node/txdb/txdb.go:205","message":"sync update"}
{"level":"info","component":"txdb","l2Block":"25","l1Block":"12526545","timestamp":"2021-05-29T02:26:10Z","time":"2022-02-22T15:03:01Z","caller":"/home/ubuntu/fuse-arb/validator/arb-rpc-node/txdb/txdb.go:205","message":"sync update"}

```


Trying to run on fuse, and got:

```
{"level":"info","component":"configuration","l1url":"https://rpc.fusespark.io","chainid":"123","time":"2022-02-22T15:14:38Z","caller":"/home/ubuntu/fuse-arb/validator/arb-util/configuration/configuration.go:597","message":"connected to l1 chain"}
{"level":"info","component":"arb-node","chainaddress":"c674399c6188ccb8e433a8b4b6d28ca0ba616104","chainid":"d753","type":"forwarder","fromBlock":12525700,"time":"2022-02-22T15:14:38Z","caller":"/home/ubuntu/fuse-arb/validator/arb-rpc-node/cmd/arb-node/arb-node.go:199","message":"Launching arbitrum node"}
{"level":"info","component":"monitor","directory":"/home/ubuntu/.arbitrum/mainnet/db","time":"2022-02-22T15:14:38Z","caller":"/home/ubuntu/fuse-arb/validator/arb-node-core/monitor/monitor.go:57","message":"database opened"}
Reloading chain to the last message saved
Initial machine load
First database checkpoint,  total gas used: 0, L1 block: 0, L2 block: 0, log count: 0, messages count: 0, timestamp: Thu Jan  1 00:00:00 1970
First valid database checkpoint,  total gas used: 0, L1 block: 0, L2 block: 0, log count: 0, messages count: 0, timestamp: Thu Jan  1 00:00:00 1970
Loaded full machine,  total gas used: 0, L1 block: 0, L2 block: 0, log count: 0, messages count: 0, timestamp: Thu Jan  1 00:00:00 1970
Reorg took 19ms
{"level":"info","component":"monitor","time":"2022-02-22T15:14:39Z","caller":"/home/ubuntu/fuse-arb/validator/arb-node-core/monitor/monitor.go:64","message":"storage initialized"}
{"level":"info","component":"broadcaster","url":"wss://fuse-arb.fuse.io/feed","time":"2022-02-22T15:14:39Z","caller":"/home/ubuntu/fuse-arb/validator/arb-util/broadcastclient/broadcastclient.go:115","message":"connecting to arbitrum inbox message broadcaster"}
{"level":"warn","component":"arb-node","stack":[{"func":"(*Monitor).StartInboxReader","line":"102","source":"monitor.go"},{"func":"startup","line":"240","source":"arb-node.go"},{"func":"main","line":"82","source":"arb-node.go"},{"func":"main","line":"255","source":"proc.go"},{"func":"goexit","line":"1581","source":"asm_amd64.s"}],"error":"error checking initial chain state: One of the blocks specified in filter (fromBlock, toBlock or blockHash) cannot be found","url":"https://rpc.fusespark.io","rollup":"0xc674399C6188cCB8e433a8b4B6d28ca0BA616104","bridgeUtils":"0xc6ec791F3F9A83A88b01A8793eD3055aC3016DA6","fromBlock":12525700,"time":"2022-02-22T15:14:39Z","caller":"/home/ubuntu/fuse-arb/validator/arb-rpc-node/cmd/arb-node/arb-node.go:258","message":"failed to start inbox reader, waiting and retrying"}

```


* who is the inbox websocket boradcaster ????
