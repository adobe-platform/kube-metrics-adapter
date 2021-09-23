.PHONY: build.docker

BINARY        ?= kube-metrics-adapter
VERSION       ?= $(shell git describe --tags --always --dirty)
IMAGE         ?= registry-write.opensource.zalan.do/teapot/$(BINARY)
TAG           ?= $(VERSION)
DOCKERFILE    ?= dc.Dockerfile

default: build.docker

build.docker:
	docker build --rm -t "$(IMAGE):$(TAG)" -f $(DOCKERFILE) --build-arg VERSION=$(VERSION) .
