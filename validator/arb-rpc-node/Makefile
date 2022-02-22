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


PRIV_KEY=0x222323232323
ETH_URL=http://
ROLLUP_CREATOR_ADD=
BRIDGE_UTILS_ADD=

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
	./bin/arb-dev-sequencer <ethURL> <rollup_creator_address> <bridge_utils_adddress>


node:
	./bin/arb-node


