# arb-avm


## Todos

- where it's deployed ?
- how to monitor it ?
- inputs and outputs ?
- what are the needed connections ?


## Results


Dependencies are loaded via git-modules, as it shows here, and
cloned into the 'external' folder. Only arb-os is not part.

```
[submodule "packages/arb-avm-cpp/external/secp256k1"]
    path = packages/arb-avm-cpp/external/secp256k1
    url = https://github.com/bitcoin-core/secp256k1.git
[submodule "packages/arb-avm-cpp/external/libff"]
    path = packages/arb-avm-cpp/external/libff
    url = https://github.com/scipr-lab/libff
[submodule "packages/arb-avm-cpp/external/Catch2"]
    path = packages/arb-avm-cpp/external/Catch2
    url = https://github.com/catchorg/Catch2
[submodule "packages/arb-avm-cpp/external/json"]
    path = packages/arb-avm-cpp/external/json
    url = https://github.com/nlohmann/json
[submodule "packages/arb-avm-cpp/cmake/cable"]
	path = packages/arb-avm-cpp/cmake/cable
	url = https://github.com/ethereum/cable
[submodule "packages/arb-avm-cpp/external/PicoSHA2"]
	path = packages/arb-avm-cpp/external/PicoSHA2
	url = https://github.com/okdshin/PicoSHA2
[submodule "packages/arb-os"]
	path = packages/arb-os
	url = https://github.com/OffchainLabs/arb-os

```

Cloc without dependencies

```
-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
C++                             68           2439           1874          15559
C/C++ Header                    59           1061           1064           4356
Go                              15            306            255           1571
CMake                           16            319            386           1553
Markdown                         3             55              0            158
YAML                             2              1              1            153
JSON                             1              0              0            107
-------------------------------------------------------------------------------
SUM:                           164           4181           3580          23457
-------------------------------------------------------------------------------

```



Could compile and run test with avm_tests [on bin folder]

```
-------------------------------------------------------------------------------
OPCODE: GT opcode is correct
-------------------------------------------------------------------------------
/home/ubuntu/arbitrum/packages/arb-avm-cpp/tests/opcodes.cpp:279
...............................................................................

benchmark name                       samples       iterations    estimated
                                     mean          low mean      high mean
                                     std dev       low std dev   high std dev
-------------------------------------------------------------------------------
gt 100x                                        100             9     2.8764 ms 
                                        2.62585 us    2.61563 us    2.66304 us 
                                        88.9801 ns    23.3219 ns    205.469 ns 
                                                                               

-------------------------------------------------------------------------------
OPCODE: ecrecover opcode is correct
-------------------------------------------------------------------------------
/home/ubuntu/arbitrum/packages/arb-avm-cpp/tests/opcodes.cpp:955
...............................................................................

benchmark name                       samples       iterations    estimated
                                     mean          low mean      high mean
                                     std dev       low std dev   high std dev
-------------------------------------------------------------------------------
ecrecover                                      100             1     7.1813 ms 
                                        71.7997 us    71.4368 us    72.5777 us 
                                        2.58331 us    1.44344 us     4.6481 us 
                                                                               

===============================================================================
All tests passed (31189 assertions in 135 test cases)

```




## Docker 

At the end, the docker with the binaries for production is called arb-node, and it's built by
a 3 phase arb-node.Dockerfile . After running the build

```
docker build -f arb-node.Dockerfile -t arb-node .
```

The image outputs:


```
REPOSITORY                  TAG       IMAGE ID       CREATED          SIZE
arb-node                    latest    256f7946440c   8 seconds ago    434MB
<none>                      <none>    3a6ec423b6f1   23 seconds ago   4.65GB
<none>                      <none>    a6abdfbf32e6   3 minutes ago    2.64GB
offchainlabs/dist-base      0.4.2     dd61684fac36   5 weeks ago      246MB
offchainlabs/backend-base   0.4.2     bfcea2a0d7ee   2 months ago     2.49GB
offchainlabs/cpp-base       0.4.1     679ebdb9f94c   2 months ago     2GB

```



Tried to run with Fuse:

```
docker run --rm -it   -v ~/arb-db/rinkeby/:/home/user/.arbitrum/rinkeby -p 0.0.0.0:8547:8547 -p 0.0.0.0:8548:8548 arb-node --l1.url https://rpc.fuse.io

```


got unrecognized network


```
ubuntu@ip-172-31-11-183:~/arbitrum/packages$ docker run --rm -it   -v ~/arb-db/rinkeby/:/home/user/.arbitrum/rinkeby -p 0.0.0.0:8547:8547 -p 0.0.0.0:8548:8548 arb-node --l1.url https://rpc.fuse.io
{"level":"info","component":"configuration","l1url":"https://rpc.fuse.io","chainid":"122","time":"2022-02-14T09:25:41Z","caller":"/home/user/arb-util/configuration/configuration.go:597","message":"connected to l1 chain"}

Sample usage:                  arb-node --conf=<filename> 
          or:  forwarder node: arb-node --l1.url=<L1 RPC> [optional arguments]

          or: aggregator node: arb-node --l1.url=<L1 RPC> --node.type=aggregator [optional arguments] [--wallet.password=pass] [--wallet.gasprice==FloatInGwei]
          or:       sequencer: arb-node --l1.url=<L1 RPC> --node.type=sequencer [optional arguments] [--wallet.password=pass] [--wallet.gasprice==FloatInGwei]
connected to unrecognized ethereum network with chain ID: 122

```


Found hardcoded config [here](https://github.com/OffchainLabs/arbitrum/blob/master/packages/arb-util/configuration/configuration.go)


but could run with eth mainet:

```
ubuntu@ip-172-31-11-183:~/arbitrum/packages$ docker run --rm -it   -v ~/arb-db/rinkeby/:/home/user/.arbitrum/rinkeby -p 0.0.0.0:8547:8547 -p 0.0.0.0:8548:8548 arb-node --l1.url https://mainnet.infura.io/v3/...
{"level":"info","component":"configuration","l1url":"https://mainnet.infura.io/v3/...","chainid":"1","time":"2022-02-14T09:35:55Z","caller":"/home/user/arb-util/configuration/configuration.go:597","message":"connected to l1 chain"}
{"level":"info","component":"arb-node","chainaddress":"c12ba48c781f6e392b49db2e25cd0c28cd77531a","chainid":"a4b1","type":"forwarder","fromBlock":12525700,"time":"2022-02-14T09:35:55Z","caller":"/home/user/arb-rpc-node/cmd/arb-node/arb-node.go:199","message":"Launching arbitrum node"}

```
