# Settings
PROG_NAME=landrush-ip
PROG_VERSION=0.1.2
GOVERSION=1.5
PWD=$(shell pwd)

OUTPUT_PATTERN=dist/landrush-ip-{{.OS}}_{{.Arch}}

# GOOS
GOOSARCH = darwin_386 \
	darwin_amd64 \
	linux_386 \
	linux_amd64 \
	linux_arm64 \
	windows_386 \
	windows_amd64

# Shared GOOS / GOARCH combinations
darwin_%: export GOOS=darwin
windows_%: export GOOS=windows
windows_%: export GOEXT=.exe
linux_%: export GOOS=linux

%_386: export GOARCH=386
%_amd64: export GOARCH=amd64
%_arm64: export GOARCH=arm64

# Phony targets
.PHONY: all deps clean $(GOOSARCH)

# Not building Darwin ports yet, sticking to Linux and Windows for now
build: clean deps
	gox \
		-output "$(OUTPUT_PATTERN)" \
		-rebuild \
		-ldflags="-s" \
		-os "linux windows" \
		-arch "386 arm arm64 amd64"

deps:
	go get github.com/mitchellh/gox
	go get -d -v

# Targets
all: clean deps $(GOOSARCH)

clean:
	@mkdir -p ./dist
	@rm -fr ./dist/*

$(GOOSARCH):
	@echo "Building $@"
	gox -output "$(OUTPUT_PATTERN)" -osarch "$(GOOS)$(GOARCH)"
