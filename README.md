# planserver
Plan Server is a server to manage execution of planning engines.

## Requirements
* [GoLang](https://golang.org/)

or

* [Docker](https://www.docker.com/)

## Features

- [ ] REST API
- [ ] Load Balancing 
- [ ] Failover
- [ ] Online PlanNode Management

## Build

### Golang & dep
Make sure `GOPATH` environment variable is set.
```bash
$ go get github.com/lechuckroh/planserver
$ cd $GOPATH/src/github.com/lechuckroh/planserver
$ make build
```

You can find binaries at:
* `app/lb/lb-app-local`
* `app/node/node-app-local`

### Docker
To build with docker:
```bash
$ make docker-build
```

You can find binaries at:
* `app/lb/lb-app`
* `app/node/node-app`

> Generated binaries are 'linux-amd64' compatible.

### Docker Image
To create a docker image:
```bash
$ make build-docker-image
```
