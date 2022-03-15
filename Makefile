
all: test vet fmt lint build


test:
	go test ./...

vet:
	go vet ./...

fmt:
	go list -f '{{.Dir}}' ./... | grep -v /vendor/ | xargs -L1 gofmt -l
	test -z $$(go list -f '{{.Dir}}' ./... | grep -v /vendor/ | xargs -L1 gofmt -l)

lint:
	go list ./... | grep -v /vendor/ | xargs -L1 golint -set_exit_status

build:
	go build -o bin/sequencer ./cmd/sequencer/main.go
	go build -o bin/validator ./cmd/validator/main.go


# copy go bindings files
copy-bindings:
	cp ../fuse-l1/out/*.go 	./util/contracts


clean:
	rm -rf go.sum
	rm -rf ./vendor/*

compile:
	fswatch -m poll_monitor -or ./cmd/* | xargs -I{} sh -c "clear && \
		go build -o bin/sequencer ./cmd/sequencer/main.go && \
		go build -o bin/validator ./cmd/validator/main.go"


deps:
	go mod init
	go mod tidy # unnecessary first time but good habit
	go mod vendor
