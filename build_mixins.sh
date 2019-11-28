#!/bin/bash

if test -d kubernetes-mixin; then
    # build kubernetes-mixin
    jsonnet -J kubernetes-mixin/vendor -m grafana-prometheus/config/prometheus_rules kubernetes-prometheus.jsonnet
    jsonnet -J kubernetes-mixin/vendor -m grafana-prometheus/config/grafana_dashboards kubernetes-grafana.jsonnet
else
    echo "kubernetes-mixin does not exist, skipping."
fi

if test -d node-mixin; then
    # build node-mixin
    jsonnet -J node-mixin/vendor -m grafana-prometheus/config/prometheus_rules node-prometheus.jsonnet
    jsonnet -J node-mixin/vendor -m grafana-prometheus/config/grafana_dashboards node-grafana.jsonnet
else
    echo "node-mixin does not exist, skipping."
fi

if test -d prometheus-mixin; then
    # build prometheus-mixin
    jsonnet -J prometheus-mixin/vendor -m grafana-prometheus/config/prometheus_rules prometheus-prometheus.jsonnet
    jsonnet -J prometheus-mixin/vendor -m grafana-prometheus/config/grafana_dashboards prometheus-grafana.jsonnet
else
    echo "prometheus-mixin does not exist, skipping."
fi

kubectl create configmap prometheus-config-rules --from-file=grafana-prometheus/config/prometheus_rules/ -o yaml --dry-run > grafana-prometheus-kube/manifest/prometheus-rules-config.yaml
echo "  namespace: monitor" >> grafana-prometheus-kube/manifest/prometheus-rules-config.yaml
kubectl create configmap grafana-volume-dashboards --from-file=grafana-prometheus/config/grafana_dashboards/ -o yaml --dry-run > grafana-prometheus-kube/manifest/grafana-dashboards-config.yaml
echo "  namespace: monitor" >> grafana-prometheus-kube/manifest/grafana-dashboards-config.yaml
#if test -d elasticsearch-mixin; then
    # build elasticsearch-mixin
#    jsonnet -J elasticsearch-mixin/vendor -m grafana-prometheus/config/prometheus_rules elasticsearch-prometheus.jsonnet
#    jsonnet -J elasticsearch-mixin/vendor -m grafana-prometheus/config/grafana_dashboards elasticsearch-grafana.jsonnet
#else
#    echo "elasticsearch-mixin does not exist, skipping."
#fi

#if test -d etcd-mixin; then
    # build etcd-mixin
#    jsonnet -J etcd-mixin/vendor -m grafana-prometheus/config/prometheus_rules etcd-prometheus.jsonnet
#    jsonnet -J etcd-mixin/vendor -m grafana-prometheus/config/grafana_dashboards etcd-grafana.jsonnet
#else
#    echo "etcd-mixin does not exist, skipping."
#fi

#if test -d nasa-swpc-mixin; then
    # build nasa-swpc-mixin
#    jsonnet -J nasa-swpc-mixin/vendor -m grafana-prometheus/config/prometheus_rules nasa-swpc-prometheus.jsonnet
#    jsonnet -J nasa-swpc-mixin/vendor -m grafana-prometheus/config/grafana_dashboards nasa-swpc-grafana.jsonnet
#else
#    echo "nasa-swpc-mixin does not exist, skipping."
#fi

#if test -d elasticsearch-mixin; then
    # build elasticsearch-mixin
#    jsonnet -J elasticsearch-mixin/vendor -m grafana-prometheus/config/prometheus_rules elasticsearch-prometheus.jsonnet
#    jsonnet -J elasticsearch-mixin/vendor -m grafana-prometheus/config/grafana_dashboards elasticsearch-grafana.jsonnet
#else
#    echo "elasticsearch-mixin does not exist, skipping."
#fi