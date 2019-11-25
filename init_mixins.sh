#!/bin/bash

if test -d kubernetes-mixin; then
    echo "kubernetes-mixin exists, skipping."
else
    git clone https://github.com/kubernetes-monitoring/kubernetes-mixin
    cd kubernetes-mixin
    jb install
    cd ..
fi

if test -d node-mixin; then
    echo "node-mixin exists, skipping."
else
    git clone https://github.com/prometheus/node_exporter node-mixin-init
    cp -r node-mixin-init/docs/node-mixin .
    rm -rf node-mixin-init
    cd node-mixin
    jb install
    cd ..
fi

if test -d prometheus-mixin; then
    echo "prometheus-mixin exists, skipping."
else
    git clone https://github.com/prometheus/prometheus prometheus-mixin-init
    cp -r prometheus-mixin-init/documentation/prometheus-mixin .
    rm -rf prometheus-mixin-init
    cd prometheus-mixin
    cp node-mixin/jsonnetfile.json prometheus-mixin/jsonnetfile.json
    jb install
    cd ..
fi

