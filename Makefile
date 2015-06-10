# Settings
PROG_NAME=landrush-ip
PROG_VERSION=0.1.1
GOVERSION=1.4
PWD=$(shell pwd)

# Phony targets
.PHONY: all clean \
	mac_x86 mac_x64 \
	win_x86 win_x64 \
	linux_x86 linux_x64

# Macro for the actual build command
build=docker run --rm \
	-v "$(PWD)":/go/src/$(PROG_NAME) \
	-w /go/src/$(PROG_NAME) \
	-e GOOS=$(1) \
	-e GOARCH=$(2) \
	golang:$(GOVERSION)-cross \
	sh -c "go get && go build -v -o ./dist/$(PROG_VERSION)/$(PROG_NAME)-$(1)-$(2)$(3)"
	
# Targets
all: clean mac_x86 mac_x64 win_x86 win_x64 linux_x86 linux_x64

clean:
	@mkdir -p ./dist/$(PROG_VERSION)
	@rm -fr ./dist/$(PROG_VERSION)/*

mac_x86:
	@echo "Building for OS X (32-bit)"
	@$(call build,darwin,386)

mac_x64:
	@echo "Building for OS X (64-bit)"
	@$(call build,darwin,amd64)

win_x86:
	@echo "Building for Windows (32-bit)"
	@$(call build,windows,386,.exe)

win_x64:
	@echo "Building for Windows (64-bit)"
	@$(call build,windows,amd64,.exe)

linux_x86:
	@echo "Building for Linux (32-bit)"
	@$(call build,linux,386)

linux_x64:
	@echo "Building for Linux (64-bit)"
	@$(call build,linux,amd64)
