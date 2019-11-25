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
    cp node-mixin/jsonnetfile.json prometheus-mixin/jsonnetfile.json
    cd prometheus-mixin
    jb install
    cd ..
fi

if test -d etcd-mixin; then
    echo "etcd-mixin exists, skipping."
else
    git clone https://github.com/etcd-io/etcd.git etcd-mixin-init
    cp -r etcd-mixin-init/Documentation/etcd-mixin .
    rm -rf etcd-mixin-init
    cd prometcdetheus-mixin
    jb install
    cd ..
fi

if test -d elasticsearch-mixin; then
    echo "elasticsearch-mixin exists, skipping."
else
    git clone https://github.com/lukas-vlcek/elasticsearch-mixin.git elasticsearch-mixin
    cd elasticsearch-mixin
    jb install
    cd ..
fi

if test -d nasa-swpc-mixin; then
    echo "nasa-swpc-mixin exists, skipping."
else
    git clone https://github.com/cznewt/nasa-swpc-exporter.git nasa-swpc-mixin-init
    cp -r nasa-swpc-mixin-init/nasa-swpc-mixin .
    rm -rf nasa-swpc-mixin-init
    cd nasa-swpc-mixin
    jb install
    cd ..
fi
