

# Run arbitrum node as described in the manual
# https://developer.offchainlabs.com/docs/running_node
#
#
check-trace:
	curl --location --request POST 'https://rinkeby.infura.io/v3/17509665a88549b9a5a5f8f3e291120c' \
		--header 'Content-Type: application/json' \
		--data-raw '{ "jsonrpc":"2.0", "method":"debug_traceTransaction", "params":["0xe5e35ee13bb6326df4da89f17504a81923299d4986de06a019ca7856cbe76bca", {"tracer": "callTracer"}], "id":1 }'

check-trace-ec2:
	curl --location --request POST '147.235.72.87:8547' \
		--header 'Content-Type: application/json' \
		--data-raw '{ "jsonrpc":"2.0", "method":"debug_traceTransaction", "params":["0xe5e35ee13bb6326df4da89f17504a81923299d4986de06a019ca7856cbe76bca", {"tracer": "callTracer"}], "id":1 }'

geth-trace:
	geth --rpcapi eth,web3,debug,txpool,net,shh,db,admin,debug \
		--rpc --ws --wsapi eth,web3,debug,txpool,net,shh,db,admin,debug  \
		--wsorigins localhost --gcmode full --rpcport=8547 --syncmode full --rinkeby


dirs:
	mkdir ~/db
	mkdir ~/db/arbitrum-rinkeby
	mkdir ~/db/arbitrum-mainnet
	chmod -fR 777 ~/db/arbitrum-rinkeby
	chmod -fR 777 ~/db/arbitrum-mainnet


run-rinkeby:
	docker run --rm -it  -v ~/db/arbitrum-rinkeby/:/home/henry/.arbitrum/rinkeby \
		-p 0.0.0.0:8547:8547 \
		-p 0.0.0.0:8548:8548 \
		offchainlabs/arb-node:v1.2.0-9214e38 \
		--l1.url https://rinkeby.infura.io/v3/17509665a88549b9a5a5f8f3e291120c

run-mainet:
	docker run --rm -it  -v ~/db/arbitrum-mainnet/:/home/henry/.arbitrum/mainnet \
		-p 0.0.0.0:8547:8547 \
		-p 0.0.0.0:8548:8548 \
		offchainlabs/arb-node:v1.2.0-9214e38 \
		--l1.url https://mainnet.infura.io/v3/17509665a88549b9a5a5f8f3e291120c

load-submodules:
	git submodule init && git submodule update
