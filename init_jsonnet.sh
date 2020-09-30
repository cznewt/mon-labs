#!/bin/bash

JSONNET_BIN="./sjsonnet.jar"

if test -f "$JSONNET_BIN"; then
    echo "$JSONNET_BIN exists, skipping."
else
    # sjsonnet much faster jsonnet implementation in java
    wget https://github.com/databricks/sjsonnet/releases/download/0.2.7/sjsonnet.jar
	chmod +x sjsonnet.jar
fi

echo "Requires Java RE, currently installed"
java --version
