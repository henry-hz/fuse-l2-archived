# Sample usage:    arb-node --conf=<filename>
#
#          FORWARDER node: arb-node --l1.url=<L1 RPC> [optional arguments]
#
#          AGGREGATOR node: arb-node --l1.url=<L1 RPC> \
#          	--node.type=aggregator [optional arguments] \ 
#          	[--wallet.password=pass] [--wallet.gasprice==FloatInGwei]
#
#          SEQUENCER: arb-node --l1.url=<L1 RPC> \
#          	--node.type=sequencer \
#          	[optional arguments] [--wallet.password=pass] [--wallet.gasprice==FloatInGwei]
#
#     TODO: add starters for the three kinds above


PRIV_KEY=0x222323232323
ROLLUP_CREATOR=0xEEf843d2A86EE6D746f4b79f8A8eECF5459e7FB7     	# Rollup creator address
ROLLUP=0xE6CDeDb4Acd04D0f467ff06863C97A77619DE226		# Rollup address
BRIDGE=0xc6ec791F3F9A83A88b01A8793eD3055aC3016DA6  		# Bridge Utils adddress
ETH_URL=https://rpc.fusespark.io

build:
	go build -o bin/arb-cli cmd/arb-cli/arb-cli.go
	go build -o bin/arb-dev-node cmd/arb-dev-node/arb-dev-node.go
	go build -o bin/arb-dev-sequencer cmd/arb-dev-sequencer/arb-dev-sequencer.go
	go build -o bin/arb-node cmd/arb-node/arb-node.go

cli:
	./bin/arb-cli https://rpc.fusespark.io $(PRIV_KEY)

dev-node:
	./bin/arb-dev-node



forwarder:
	go build -o bin/arb-node cmd/arb-node/arb-node.go
	./bin/arb-node --l1.url=https://mainnet.infura.io/v3/17509665a88549b9a5a5f8f3e291120c

forwarder-spark:
	go build -o bin/arb-node cmd/arb-node/arb-node.go
	./bin/arb-node --l1.url=https://rpc.fusespark.io

agg-rink:
	rm -rf arbitrum*
	go build -o bin/arb-node cmd/arb-node/arb-node.go
	./bin/arb-node --l1.url=https://rinkeby.infura.io/v3/17509665a88549b9a5a5f8f3e291120c \
		--node.type=aggregator

agg-main:
	rm -rf arbitrum*
	go build -o bin/arb-node cmd/arb-node/arb-node.go
	./bin/arb-node --l1.url=https://mainnet.infura.io/v3/17509665a88549b9a5a5f8f3e291120c \
		--node.type=aggregator

agg:
	rm -rf arbitrum*
	go build -o bin/arb-node cmd/arb-node/arb-node.go
	./bin/arb-node --l1.url=https://rpc.fusespark.io \
		--node.type=aggregator

seq:
	rm -rf arbitrum*
	go build -o bin/arb-node cmd/arb-node/arb-node.go
	./bin/arb-node --l1.url=https://mainnet.infura.io/v3/17509665a88549b9a5a5f8f3e291120c \
		--node.type=sequencer


dev-seq:
	go build -o bin/arb-dev-sequencer cmd/arb-dev-sequencer/arb-dev-sequencer.go
	./bin/arb-dev-sequencer $(ETH_URL) $(ROLLUP_CREATOR) $(BRIDGE) 


