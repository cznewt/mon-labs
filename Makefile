
init_mixins:
	git clone https://github.com/kubernetes-monitoring/kubernetes-mixin
	cd ./kubernetes-mixin/
	make dashboards_out
	cp dashboards_out/* ../grafana-prometheus/config/grafana_dashboards

