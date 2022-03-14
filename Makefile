
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
	go build -o bin/api ./cmd/api
	go build -o bin/worker ./cmd/worker


# copy go bindings files
copy-bindings:
	cp ../fuse-l1/out/*.go 	./util/contracts


compile:
	fswatch -m poll_monitor -or ./val | xargs -I{} sh -c "clear && go build val/main.go"


deps:
	go mod init
	go mod tidy # unnecessary first time but good habit
	go mod vendor
