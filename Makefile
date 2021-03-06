###############################################################################
# The build architecture is select by setting the ARCH variable.
# For example: When building on ppc64le you could use ARCH=ppc64le make <....>.
# When ARCH is undefined it defaults to amd64.
ARCH?=amd64

# Determine which OS.
OS?=$(shell uname -s | tr A-Z a-z)

# Get version from git.
GIT_VERSION?=$(shell git describe --tags --dirty)
CERT_DIR?=/tmp/kube-checker

KUBE_CHECKER_API?=kube-checker-api
KUBE_CHECKER_UI?=kube-checker-ui
KUBE_CHECKER_JOB?=kube-checker-job

.PHONY: all binary clean help ssl-keys
default: help

## Make all targets
all: cmds

## Generate all cmds
cmds: $(KUBE_CHECKER_API) $(KUBE_CHECKER_UI) $(KUBE_CHECKER_JOB)

$(KUBE_CHECKER_API):
	$(MAKE) OS=$(OS) ARCH=$(ARCH) BINARY=$(KUBE_CHECKER_API) binary

$(KUBE_CHECKER_JOB):
	$(MAKE) OS=$(OS) ARCH=$(ARCH) BINARY=$(KUBE_CHECKER_JOB) binary

$(KUBE_CHECKER_UI):
	$(MAKE) OS=$(OS) ARCH=$(ARCH) BINARY=$(KUBE_CHECKER_UI) binary

## Run API Server
run-api-server: $(KUBE_CHECKER_API) ssl-keys
	./dist/$(KUBE_CHECKER_API)-$(OS)-$(ARCH) --tls-certificate $(CERT_DIR)/dev.crt --tls-key $(CERT_DIR)/dev.key

ssl-keys:
	mkdir -p $(CERT_DIR)
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout $(CERT_DIR)/dev.key -out $(CERT_DIR)/dev.crt \
		-subj "/C=IN/ST=MH/L=Pune/CN=kubechecker.com/emailAddress=sanket@infracloud.com"

binary:
	GOOS=$(OS) GOARCH=$(ARCH) CGO_ENABLED=0 go build -o dist/$(BINARY)-$(OS)-$(ARCH) \
	-ldflags "-X main.VERSION=$(GIT_VERSION)" cmd/$(BINARY)/main.go

## Generate swagger code
swagger-codegen:
	swagger generate server -f design/spec/swagger.yaml -t ./pkg/
	mv pkg/cmd/kubechecker-server/main.go cmd/$(KUBE_CHECKER_API)/
	rm -r pkg/cmd

## Cleanup all build files
clean:
	rm -r dist

.PHONY: help
## Display this help text.
help: # Some kind of magic from https://gist.github.com/rcmachado/af3db315e31383502660
	$(info Available targets)
	@awk '/^[a-zA-Z\-\_0-9\/]+:/ {                                      \
		nb = sub( /^## /, "", helpMsg );                                \
		if(nb == 0) {                                                   \
			helpMsg = $$0;                                              \
			nb = sub( /^[^:]*:.* ## /, "", helpMsg );                   \
		}                                                               \
		if (nb)                                                         \
			printf "\033[1;31m%-" width "s\033[0m %s\n", $$1, helpMsg;  \
	}                                                                   \
	{ helpMsg = $$0 }'                                                  \
	width=20                                                            \
	$(MAKEFILE_LIST)
