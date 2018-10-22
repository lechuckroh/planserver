GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
DEP=dep

VERSION ?= 3

PACKAGE_LB=app/lb
PACKAGE_NODE=app/node
DOCKERFILE_LB=Dockerfile.lb
DOCKERFILE_NODE=Dockerfile.node
DOCKER_IMAGE_LB=planserver-lb:$(VERSION)
DOCKER_IMAGE_NODE=planserver-node:$(VERSION)

BINARY_LB=lb-app
BINARY_NODE=node-app
BINARY_LB_LOCAL=$(BINARY_LB)-local
BINARY_NODE_LOCAL=$(BINARY_NODE)-local

all: test build

# Build
build: build-lb build-node 
build-lb:
	cd $(PACKAGE_LB) && $(GOBUILD) -o $(BINARY_LB_LOCAL) -v
build-node:
	cd $(PACKAGE_NODE) && $(GOBUILD) -o $(BINARY_NODE_LOCAL) -v

# Test
test: test-lb test-node
test-lb:
	cd $(PACKAGE_LB) && $(GOTEST) -v -count=1 ./...
test-node:
	cd $(PACKAGE_NODE) && $(GOTEST) -v -count=1 ./...

# Clean
clean: clean-lb clean-node
clean-lb:
	$(GOCLEAN)
	rm -f $(PACKAGE_LB)/$(BINARY_LB)
	rm -f $(PACKAGE_LB)/$(BINARY_LB_LOCAL)
clean-node:
	$(GOCLEAN)
	rm -f $(PACKAGE_NODE)/$(BINARY_NODE)
	rm -f $(PACKAGE_NODE)/$(BINARY_NODE_LOCAL)

# Run
run-lb:
	cd $(PACKAGE_LB) && $(GOBUILD) -o $(BINARY_LB_LOCAL) -v ./...
	./$(PACKAGE_LB)/$(BINARY_LB_LOCAL)
run-node:
	cd $(PACKAGE_NODE) && $(GOBUILD) -o $(BINARY_NODE_LOCAL) -v ./...
	./$(PACKAGE_NODE)/$(BINARY_NODE_LOCAL)

# Install dependencies
deps:
	$(DEP) ensure

# Cross compilation
build-linux: build-lb-linux build-node-linux
build-lb-linux:
	cd $(PACKAGE_LB) && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 $(GOBUILD) -o $(BINARY_LB) -v
build-node-linux:
	cd $(PACKAGE_NODE) && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 $(GOBUILD) -o $(BINARY_NODE) -v

# Build linux-amd64 binary using docker
docker-build: docker-build-lb docker-build-node
docker-build-lb:
	docker run --rm -v `pwd`:/usr/src/myapp -w /usr/src/myapp/$(PACKAGE_LB) golang:latest $(GOBUILD) -o $(BINARY_LB) -v
docker-build-node:
	docker run --rm -v `pwd`:/usr/src/myapp -w /usr/src/myapp/$(PACKAGE_NODE) golang:latest $(GOBUILD) -o $(BINARY_NODE) -v

# Test using docker
docker-test: docker-test-lb docker-test-node
docker-test-lb:
	docker run --rm -v `pwd`:/usr/src/myapp -w /usr/src/myapp/$(PACKAGE_LB) golang:latest $(GOTEST) -v -count=1 ./...
docker-test-node:
	docker run --rm -v `pwd`:/usr/src/myapp -w /usr/src/myapp/$(PACKAGE_NODE) golang:latest $(GOTEST) -v -count=1 ./...

# Build docker image
build-docker-image: build-docker-image-lb build-docker-image-node
build-docker-image-lb: docker-build-lb
	docker build -f $(DOCKERFILE_LB) -t $(DOCKER_IMAGE_LB) .
build-docker-image-node: docker-build-node
	docker build -f $(DOCKERFILE_NODE) -t $(DOCKER_IMAGE_NODE) .
