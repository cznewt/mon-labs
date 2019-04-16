#!/bin/bash

git clone https://github.com/kubernetes-monitoring/kubernetes-mixin
cd kubernetes-mixin
jb install
make clean
make dashboards_out
cp dashboards_out/* ../grafana-prometheus/config/grafana_dashboards
make prometheus_alerts.yaml
cp prometheus_alerts.yaml ../grafana-prometheus/config/prometheus_rules/kube_alerts.yml
make prometheus_rules.yaml
cp prometheus_rules.yaml ../grafana-prometheus/config/prometheus_rules/kube_rules.yml