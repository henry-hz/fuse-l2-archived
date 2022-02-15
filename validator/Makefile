


build-docker:
	docker build -t arb-node .


run-rinkeby:
	docker run --rm -it \
		-v ~/arb-db/rinkeby/:/home/user/.arbitrum/rinkeby \
		-p 0.0.0.0:8547:8547 -p 0.0.0.0:8548:8548 arb-node \
		--l1.url https://rinkeby.infura.io/v3/17509665a88549b9a5a5f8f3e291120c

run-mainnet:
	docker run --rm -it \
		-v ~/arb-db/rinkeby/:/home/user/.arbitrum/rinkeby \
		-p 0.0.0.0:8547:8547 -p 0.0.0.0:8548:8548 arb-node \
		--l1.url https://mainnet.infura.io/v3/17509665a88549b9a5a5f8f3e291120c
