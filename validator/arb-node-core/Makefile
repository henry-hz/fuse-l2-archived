

build:
	go build -o bin/arb-validator cmd/arb-validator/arb-validator.go
	go build -o bin/arb-relay cmd/arb-relay/arb-relay.go
	go build -o bin/proof-server cmd/proof-test-server/proof_test_server.go


run-validator:
	./bin/arb-validator --l1.url=https://rpc.fusespark.io --feed.input.url=https:/rpc.fusespark.io:8546


