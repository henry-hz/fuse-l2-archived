

# Run arbitrum node as described in the manual
# https://developer.offchainlabs.com/docs/running_node

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
