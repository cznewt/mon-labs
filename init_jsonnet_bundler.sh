#!/bin/bash

JSONNET_BUNDLER_BIN="/usr/local/bin/jb"
JSONNET_BUNDLER_SOURCE="https://github.com/jsonnet-bundler/jsonnet-bundler/releases/download/v0.1.0/jb-linux-amd64"

if test -f "$JSONNET_BUNDLER_BIN"; then
    echo "$JSONNET_BUNDLER_BIN exists, skipping."
else
    # sjsonnet much faster jsonnet implementation in java
    wget "$JSONNET_BUNDLER_SOURCE"
	sudo chmod +x jb-linux-amd64
	sudo mv jb-linux-amd64 "$JSONNET_BUNDLER_BIN"
fi

echo "Jsonnet Bundler version:"
jb -h
