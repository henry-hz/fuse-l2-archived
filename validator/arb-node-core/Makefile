# wallet:  [pass: jim]
# {"address":"0ab6697a64de6a49aa7f207f5b0033f922a7c5af","crypto":{"cipher":"aes-128-ctr","ciphertext":"8254c802b8a5d8d8af01143f90b287ca63e9e5db31ba98c40ce7310e35f97980","cipherparams":{"iv":"bc51e245d3c742c7469ae0f505eab9e9"},"kdf":"scrypt","kdfparams":{"dklen":32,"n":262144,"p":1,"r":8,"salt":"813f77585b2e6798867ec1af44589e1e6c4d3bc77e17be998773ce55f42ebe61"},"mac":"b2f0ae1be3e44f6573bfbb81a13ed69dfaddddb45ed018c5df93708231109e0d"},"id":"3bd6f5f6-caf8-436b-9568-a097f0243536","version":3}

build:
	go build -o bin/arb-validator cmd/arb-validator/arb-validator.go
	go build -o bin/arb-relay cmd/arb-relay/arb-relay.go
	go build -o bin/proof-server cmd/proof-test-server/proof_test_server.go


validator-spark:
	go build -o bin/arb-validator cmd/arb-validator/arb-validator.go
	./bin/arb-validator --l1.url=https://rpc.fusespark.io --feed.input.url=ws://localhost:9642

validator2:
	go build -o bin/arb-validator cmd/arb-validator/arb-validator.go
	./bin/arb-validator --l1.url=https://rpc.fusespark.io

validator-rinkeby-local:
	go build -o bin/arb-validator cmd/arb-validator/arb-validator.go
	./bin/arb-validator --l1.url=https://rinkeby.infura.io/v3/17509665a88549b9a5a5f8f3e291120c \
		--feed.input.url=wss://rinkeby.arbitrum.io/feed

# wallet password: jim
validator-mainet:
	go build -o bin/arb-validator cmd/arb-validator/arb-validator.go
	./bin/arb-validator --l1.url=https://mainnet.infura.io/v3/17509665a88549b9a5a5f8f3e291120c \
		--feed.input.url=wss://mainet.arbitrum.io/feed


