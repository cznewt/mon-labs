
init_base:
	./init_jsonnet.sh
	./init_jsonnet_bundler.sh

clean:
	rm -rf "./elasticsearch-mixin"
	rm -rf "./etcd-mixin"
	rm -rf "./kubernetes-mixin"
	rm -rf "./nasa-swpc-mixin"
	rm -rf "./node-mixin"
	rm -rf "./prometheus-mixin"
	rm -rf "./jsonnet-utils"
	rm -rf "./python-libmetric"

init_mixins:
	./init_mixins.sh

init_utils:
	./init_jsonnet_utils.sh
	./init_libmetric.sh

build_demo_mixin:
	./sjsonnet.jar -J kubernetes-mixin/vendor -m ./grafana-prometheus/config/grafana_dashboards mixins/demo-mixin/dashboards.jsonnet

convert_grafana_dashboards:
	mkdir grafana_out -p
	./jsonnet-utils/venv/bin/jsonnet-utils-grafana-convert --build-path=./grafana_out --source-path=./grafana-prometheus/config/grafana_dashboards

grafana_metrics:
	mkdir grafana_out -p
	./jsonnet-utils/venv/bin/jsonnet-utils-grafana-metrics --path=./grafana-prometheus/config/grafana_dashboards

prometheus_metrics:
	mkdir grafana_out -p
	./jsonnet-utils/venv/bin/jsonnet-utils-prometheus-metrics --path=./grafana-prometheus/config/prometheus_rules

convert_prometheus_rules:
	mkdir prometheus_out -p
	./jsonnet-utils/venv/bin/jsonnet-utils-prometheus-convert --build-path=./prometheus_out --source-path=./grafana-prometheus/config/prometheus_rules

query_prometheus_range:
	./python-libmetric/venv/bin/range_metric --url=http://localhost:9090 --engine=prometheus --query=probe_duration_seconds \
	  --start=2019-04-16T00:00:00Z --end=2019-04-18T00:00:00Z --step=60s

query_prometheus_instant:
	./python-libmetric/venv/bin/instant_metric --url=http://localhost:9090 --engine=prometheus --query=probe_duration_seconds \
	  --moment=2019-04-18T00:00:00Z
