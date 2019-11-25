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