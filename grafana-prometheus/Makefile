
CWD=$(shell pwd)

help:
	@echo "Available actions (project grafana_prom_devel):"
	@echo "  apply                  Deploy service resources"
	@echo "  delete                 Delete service resources"
	@echo "  status                 Get service resources"

apply:
	sudo chmod 777 ./volume/* -R
	sudo docker-compose -p grafana_prom_devel up -d

delete:
	sudo docker-compose -p grafana_prom_devel stop
	sudo docker-compose -p grafana_prom_devel rm -f

status:
	@echo "Existing resources (project grafana_prom_devel):"
	sudo docker-compose -p grafana_prom_devel ps
