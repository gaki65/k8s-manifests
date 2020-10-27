FLAGS =
TESTENVVAR =
REGISTRY = gaki65
TAG_PREFIX = v
VERSION = $(shell cat VERSION)
TAG = $(TAG_PREFIX)$(VERSION)
LATEST_RELEASE_BRANCH := release-$(shell grep -ohE "[0-9]+.[0-9]+" VERSION)
PKGS = $(shell go list ./... | grep -v /vendor/ | grep -v /tests/e2e)
ARCH ?= $(shell go env GOARCH)
BuildDate = $(shell date -u +'%Y-%m-%dT%H:%M:%SZ')
Commit = $(shell git rev-parse --short HEAD)
ALL_ARCH = amd64 arm arm64 ppc64le s390x
PKG = k8s.io/kube-state-metrics/pkg
GO_VERSION = 1.13
FIRST_GOPATH := $(firstword $(subst :, ,$(shell go env GOPATH)))
BENCHCMP_BINARY := $(FIRST_GOPATH)/bin/benchcmp
GOLANGCI_VERSION := v1.22.2
HAS_GOLANGCI := $(shell which golangci-lint)
IMAGE = $(REGISTRY)/kube-state-metrics
MULTI_ARCH_IMG = $(IMAGE)-$(ARCH)
validate-modules:
	@echo "- Verifying that the dependencies have expected content..."
	go mod verify
	@echo "- Checking for any unused/missing packages in go.mod..."
