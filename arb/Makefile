# Latest Docker Image: offchainlabs/arb-node:v1.2.0-9214e38
# - `--l1.url=<Layer 1 Ethereum RPC URL>`
# - RPC: `8547`
# - WebSocket: `8548`
# - Sequencer Feed: `9642`
# example: 
# docker run --rm -it  -v /some/local/dir/arbitrum-mainnet/:/home/user/.arbitrum/mainnet \
# -p 0.0.0.0:8547:8547 -p 0.0.0.0:8548:8548 offchainlabs/arb-node:v1.2.0-9214e38 
#  --l1.url https://l1-node:8545
#  See docs/Running_Node.md
#  LOCAL DISK MAP:  [you have to give docker usdr UID 1000 to access the host folder
#  chmod -fR 777 /some/local/dir/arbitrum-mainnet
#  [here we are using ~/arb-db/arbitrum]
#  docker run -t -i -v <host_dir>:<container_dir>  ubuntu /bin/bash   <map folders>

CONTAINER_NAME=arb-node


run-avm:
	mkdir ./arb-avm-cpp/release
	cd ./arb-avm-cpp/release
	cmake .. -DCMAKE_BUILD_TYPE=Release
	cmake --build .
	cd bin
	mkdir db
	wget https://raw.githubusercontent.com/OffchainLabs/arb-os/26ab8d7c818681c4ee40792aeb12981a8f2c3dfa/arb_os/arbos.mexe
	./arbcore_runner ./db ./arbos.mexe
	

	./arbcore_runner ./db ./arbos.mexe

build-docker:
	docker build -t $(CONTAINER_NAME) .

clear-dbs:
	rm -rf ~/arb-db/mainnet/*
	rm -rf ~/arb-db/rinkeby/*

create-db-dirs:
	mkdir ~/arb-db
	mkdir ~/arb-db/mainnet && mkdir ~/arb-db/rinkeby
	sudo chmod 777 ~/arb-db
	sudo chmod 777 ~/arb-db/mainnet && sudo chmod 777 ~/arb-db/rinkeby

run-rinkeby:
	docker run --rm -it \
		-v ~/arb-db/rinkeby/:/home/user/.arbitrum/rinkeby \
		-p 0.0.0.0:8547:8547 -p 0.0.0.0:8548:8548 $(CONTAINER_NAME) \
		--l1.url https://rinkeby.infura.io/v3/17509665a88549b9a5a5f8f3e291120c

run-mainnet:
	docker run --rm -it \
		-v ~/arb-db/mainnet/:/home/user/.arbitrum/mainnet \
		-p 0.0.0.0:8547:8547 -p 0.0.0.0:8548:8548 $(CONTAINER_NAME) \
		--l1.url https://mainnet.infura.io/v3/17509665a88549b9a5a5f8f3e291120c

# --sequencer  --password=jim state https://rpc.fusespark.io 0xa2D6322FeAcAE2df3245F62e3Ae884FCDC975cdd
run-sparknet:
	docker run --rm -it \
		-v ~/arb-db/sparknet/:/home/user/.arbitrum/sparknet \
		-p 0.0.0.0:8547:8547 -p 0.0.0.0:8548:8548 $(CONTAINER_NAME) \
		--l1.url https://rpc.fusespark.io
