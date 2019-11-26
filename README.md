
# Monitoring Labs

Simple monitoring infrastructure.

## Grafana/Prometheus

* grafana - http://localhost:3000/ admin:heslo
* prometheus - http://localhost:9090/
* blackbox-exporter http://localhost:9115/
* node-exporter http://http://localhost:9100/
* cadvisor http://localhost:8080/containers/
* statsd-exporter

## Monitoring Mixins

Basic overview at https://github.com/monitoring-mixins/docs.

* elasticsearch - https://github.com/lukas-vlcek/elasticsearch-mixin
* etcd - https://github.com/etcd-io/etcd/tree/master/Documentation/etcd-mixin
* kubernetes - https://github.com/kubernetes-monitoring/kubernetes-mixin
* nasa-swpc - https://github.com/cznewt/nasa-swpc-exporter/tree/master/nasa-swpc-mixin
* node-exporter - https://github.com/prometheus/node_exporter/tree/master/docs/node-mixin
* prometheus - https://github.com/prometheus/prometheus/tree/master/documentation/prometheus-mixin


## Use JSONNET Utils

* Install utils `./install_jsonnet_utils.sh`.
* Source environment with `source jsonnet-utils/venv/bin/activate`.
* Check Prometheus rules `make prometheus_metrics`
* Check Grafana metrics `make grafana_metrics`

## Generate mixin with Cookiecutter

* Install utils `./install_jsonnet_utils.sh`.
* Source environment with `source jsonnet-utils/venv/bin/activate`.
* Run `cookiecutter mixin-template`
