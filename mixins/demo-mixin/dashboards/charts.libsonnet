local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local template = grafana.template;
local singlestat = grafana.singlestat;
local graphPanel = grafana.graphPanel;
local pieChartPanel = grafana.pieChartPanel;
local prometheus = grafana.prometheus;

local chartSinglestat =
  singlestat.new(
    title='Version',
    datasource='Prometheus',
    format='none',
    valueName='name',
  ).addTarget(
    prometheus.target(
      'prometheus_build_info{instance="$instance"}',
      legendFormat='{{ version }}',
    )
  );

local chartPieChartPanel =
  pieChartPanel.new(
    'test',
    span=12,
    datasource='$PROMETHEUS',
    description='description',
    aliasColors={ '2xx': '#7EB26D', '4xx': '#F2C96D', '5xx': '#BF1B00' },
    pieType='donut',
    repeat='repeat_variable',
    repeatDirection='h',
    maxPerRow=5,
  )
  .addTarget({ a: 'foo' })
  .addTarget({ b: 'foo' });

local chartGraphPanel =
  graphPanel.new(
    title='Network traffic on eth0',
    datasource='Prometheus',
    linewidth=2,
    format='Bps',
    aliasColors={
      Rx: 'light-green',
      Tx: 'light-red',
    },
  ).addTarget(
    prometheus.target(
      'rate(node_network_receive_bytes_total{}[1m])',
      legendFormat='Rx',
    )
  ).addTarget(
    prometheus.target(
      'irate(node_network_transmit_bytes_total{}) * (-1)',
      legendFormat='Tx',
    )
  );

local datasource_template = template.datasource(
  'PROMETHEUS_DS',
  'prometheus',
  'Prometheus',
  hide='label',
);

local instance_template = template.new(
  'instance',
  '$PROMETHEUS_DS',
  'label_values(prometheus_build_info, instance)',
  label='Instance',
  refresh='time',
);

{
  grafanaDashboards+:: {
    'chart-singlestat.json':
      dashboard.new('Chart Singlestat', schemaVersion=18)
      .addTemplate(datasource_template)
      .addTemplate(instance_template)
      .addPanels(
        [
          chartSinglestat { gridPos: { h: 4, w: 3, x: 0, y: 0 } },
        ]
      ),
    'chart-graphpanel.json':
      dashboard.new('Chart GraphPanel', schemaVersion=18)
      .addTemplate(datasource_template)
      .addTemplate(instance_template)
      .addPanels(
        [
          chartGraphPanel { gridPos: { h: 8, w: 12, x: 0, y: 0 } },
        ]
      ),
    'chart-piechart.json':
      dashboard.new('Chart PieChart', schemaVersion=18)
      .addTemplate(datasource_template)
      .addTemplate(instance_template)
      .addPanels(
        [
          chartPieChart { gridPos: { h: 10, w: 10, x: 0, y: 4 } },
        ]
      ),
  },
}
