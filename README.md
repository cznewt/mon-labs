
# Monitoring Labs

Simple monitoring infrastructure.

## Grafana/Prometheus

* grafana - http://localhost:3000/ admin:heslo https://grafana.com/docs/
* prometheus - http://localhost:9090/ https://prometheus.io/docs/
* blackbox-exporter http://localhost:9115/
* cloudprober http://localhost:9313/metrics https://cloudprober.org/
* node-exporter http://http://localhost:9100/
* cadvisor http://localhost:8080/containers/
* pushgateway http://localhost:9091/ https://github.com/prometheus/pushgateway
* statsd-exporter http://localhost:9102/

## Monitoring Mixins

Basic overview at https://github.com/monitoring-mixins/docs.

* elasticsearch - https://github.com/lukas-vlcek/elasticsearch-mixin
* etcd - https://github.com/etcd-io/etcd/tree/master/Documentation/etcd-mixin
* kubernetes - https://github.com/kubernetes-monitoring/kubernetes-mixin
* nasa-swpc - https://github.com/cznewt/nasa-swpc-exporter/tree/master/nasa-swpc-mixin
* node-exporter - https://github.com/prometheus/node_exporter/tree/master/docs/node-mixin
* prometheus - https://github.com/prometheus/prometheus/tree/master/documentation/prometheus-mixin

## Installing Lab

Tested to work on Ubuntu 18.04.

* Install docker `./init_docker.sh`
* Install JSONNET compiler`./init_jsonnet.sh`
* Install JSONNET bundler `./init_jsonnet_bundler.sh`
* Install monitoring mixins `./init/init_mixins.sh`
* Build monitoring mixins `./init/build_mixins.sh`
* Run the docker-compose environment `cd ./grafana-prometheus/; make apply`

## Use JSONNET Utils

* Install utils `./init_jsonnet_utils.sh`
* Source environment with `source jsonnet-utils/venv/bin/activate`
* Check Prometheus rules `make prometheus_metrics`
* Check Grafana metrics `make grafana_metrics`

## Generate new mixin with Cookiecutter

* Install utils `./init_jsonnet_utils.sh`.
* Source environment with `source jsonnet-utils/venv/bin/activate`.
* Run `cookiecutter mixin-template`
* Change to newly created mixin dir and type `make init` and `make build`.

## Use metrics for data analytics

* Install client `./init_libmetric.sh`
* Create Pandas DataFrame from Prometheus instant data `make query_prometheus_instant`
* Create Pandas DataFrame from Prometheus range data `make query_prometheus_range`
