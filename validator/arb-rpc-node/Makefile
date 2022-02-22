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
ROLLUP=0xEEf843d2A86EE6D746f4b79f8A8eECF5459e7FB7     	# Rollup creator address
BRIDGE=0xc6ec791F3F9A83A88b01A8793eD3055aC3016DA6  	# Bridge Utils adddress
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




dev-sequencer:
	./bin/arb-dev-sequencer $(ETH_URL) $(ROLLUP) $(BRIDGE) 


forwarder:
	./bin/arb-node --l1.url=https://mainnet.infura.io/v3/17509665a88549b9a5a5f8f3e291120c

agg:
	./bin/arb-node --l1.url=https://mainnet.infura.io/v3/17509665a88549b9a5a5f8f3e291120c \
		--node.type=aggregator

seq:
	./bin/arb-node --l1.url=https://mainnet.infura.io/v3/17509665a88549b9a5a5f8f3e291120c \
		--node.type=sequencer


node:
	./bin/arb-node


