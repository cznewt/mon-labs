

init:
	jb install

build:
	jsonnet -J vendor -m ../grafana-prometheus/config/prometheus_rules prometheus.jsonnet
	jsonnet -J vendor -m ../grafana-prometheus/config/grafana_dashboards grafana.jsonnet
