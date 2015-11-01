# Settings
PROG_NAME=landrush-ip
PROG_VERSION=0.1.2
GOVERSION=1.5
PWD=$(shell pwd)

# GOOS
GOOSARCH = darwin_386 \
	darwin_amd64 \
	linux_386 \
	linux_amd64 \
	windows_386 \
	windows_amd64

# Shared GOOS / GOARCH combinations
darwin_%: export GOOS=darwin
windows_%: export GOOS=windows
windows_%: export GOEXT=.exe
linux_%: export GOOS=linux

%_386: export GOARCH=386
%_amd64: export GOARCH=amd64

# Phony targets
.PHONY: all clean $(GOOSARCH)

build:
	gox -output "dist/{{.OS}}_{{.Arch}}_{{.Dir}}"
ifeq ($(TRAVIS),true)
ifeq ($(strip $(TRAVIS_TAG)),)
	ghr --username Werelds --replace $(TRAVIS_BRANCH) dist/
else
	ghr --username Werelds --replace $(TRAVIS_TAG) dist/
endif
else
	ghr --username Werelds --replace --prerelease --debug pre-release dist/
endif

# Targets
all: clean $(GOOSARCH)

clean:
	@mkdir -p ./dist/$(PROG_VERSION)
	@rm -fr ./dist/$(PROG_VERSION)/*

$(GOOSARCH):
	@echo "Building $@"
	go build -o ./dist/$(PROG_VERSION)/$(PROG_NAME)-$(GOOS)-$(GOARCH)$(GOEXT)