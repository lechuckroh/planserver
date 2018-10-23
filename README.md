# planserver
[![Build Status](https://travis-ci.org/lechuckroh/planserver.svg?branch=develop)](https://travis-ci.org/lechuckroh/planserver)

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
### with Golang
Make sure `GOPATH` environment variable is set.
```bash
$ go get github.com/lechuckroh/planserver
$ cd $GOPATH/src/github.com/lechuckroh/planserver
$ make build
```

You can find binaries at:
* `app/lb/lb-app-local`
* `app/node/node-app-local`

### with Docker
To build with docker:
```bash
$ make docker-build
```

You can find binaries at:
* `app/lb/lb-app`
* `app/node/node-app`

> Generated binaries are 'linux-amd64' compatible.

### Docker Image
To create docker images:
```bash
# Build docker image with default version (3)
$ make build-docker-image

# Build docker image with version
$ VERSION=3.0.1 make build-docker-image
```

To push docker images:
```bash
# Push planserver-lb
$ VERSION=3.1 DOCKER_REGISTRY=192.168.2.10 DOCKER_REGISTRY_PROJECT=planserver make push-docker-image-lb
# Push planserver-node
$ VERSION=3.2 DOCKER_REGISTRY=192.168.2.10 DOCKER_REGISTRY_PROJECT=planserver make push-docker-image-node
```

It will create an image tag (`192.168.2.10/planserver/planserver-lb:3.1`) and push to the registry.
> * You should have a privileges to push images.
> * If registry uses HTTP, you will need to add the option `--insecure-registry` to your client's Docker daemon and restart the Docker service.
