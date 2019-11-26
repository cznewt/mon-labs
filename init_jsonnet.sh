#!/bin/bash

JSONNET_BIN="/usr/local/bin/jsonnet"

if test -f "$JSONNET_BIN"; then
    echo "$JSONNET_BIN exists, skipping."
else
    # sjsonnet much faster jsonnet implementation in java
    wget https://github.com/databricks/sjsonnet/releases/download/0.1.6/sjsonnet.jar
	sudo chmod +x sjsonnet.jar
	sudo cp sjsonnet.jar /usr/local/bin/jsonnet
    rm sjsonnet.jar
fi

sudo apt install -y default-jre

echo "Requires Java RE, currently installed:"
java --version
