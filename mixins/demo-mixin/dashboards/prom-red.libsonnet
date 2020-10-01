local g = import 'grafana-builder/grafana.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local row = grafana.row;
local prometheus = grafana.prometheus;
local template = grafana.template;
local graphPanel = grafana.graphPanel;
local singlestat = grafana.singlestat;

{
  grafanaDashboards+:: {
    'prometheus-red-method.json':
      local serviceStatus =
        graphPanel.new(
          'QPS',
          datasource='$datasource',
          fill=10,
          min=0,
          span=6,
          linewidth=0,
          stack=true,
          format='ops',
          legend_values=true,
          legend_current=true,
        )
        .addTarget(prometheus.target(
          |||
            sum(rate(prometheus_http_requests_total{instance="$instance", code=~"(2|3).."}[5m]))
          ||| % $._config,
          legendFormat='Success',
          intervalFactor=1,
        ))
        .addTarget(prometheus.target(
          |||
            sum(rate(prometheus_http_requests_total{instance="$instance", code=~"(4|5).."}[5m]))
          ||| % $._config,
          legendFormat='Failure',
          intervalFactor=1,
        )) +
        {
          aliasColors: {
            Success: '#7EB26D',
            Failure: '#BF1B00',
          },
        };
      local serviceLatency =
        graphPanel.new(
          'Latency',
          datasource='$datasource',
          span=6,
          min=0,
        )
      .addTarget(
        prometheus.target(
          'histogram_quantile(0.5, sum(rate(prometheus_http_request_duration_seconds_bucket{instance="$instance"}[5m])) by (le))' % $._config,
          legendFormat='p50'
        )
      )
      .addTarget(
        prometheus.target(
          'histogram_quantile(0.95, sum(rate(prometheus_http_request_duration_seconds_bucket{instance="$instance"}[5m])) by (le))' % $._config,
          legendFormat='p95'
        )
      )
      .addTarget(
        prometheus.target(
          'histogram_quantile(0.99, sum(rate(prometheus_http_request_duration_seconds_bucket{instance="$instance"}[5m])) by (le))' % $._config,
          legendFormat='p99'
        )
      );
      g.dashboard('Prometheus RED Method Analysis')
      .addTemplate('instance', 'prometheus_build_info' % $._config, 'instance')
      .addRow(
        row.new('Service $instance Stats')
        .addPanel(serviceStatus)
        .addPanel(serviceLatency)
      ),
  },
}
