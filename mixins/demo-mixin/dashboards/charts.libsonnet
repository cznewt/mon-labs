local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local template = grafana.template;
local singlestat = grafana.singlestat;
local graphPanel = grafana.graphPanel;
local pieChartPanel = grafana.pieChartPanel;
local gaugePanel = grafana.gaugePanel;
local heatmapPanel = grafana.heatmapPanel;
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

local chartHeatmap =
  heatmapPanel.new(
    'color spectrum cubehelix test',
    color_mode='spectrum',
    color_min=0,
    color_max=100,
    color_colorScheme='interpolateCubehelixDefault',
    dataFormat='tsbuckets',
  )
  .addTarget(
    prometheus.target(
      'rate(node_network_receive_bytes_total[1m])',
      legendFormat='Rx',
    )
  );
local chartPieChartPanel =
  pieChartPanel.new(
    'Pie Chart Demo',
    aliasColors={ '2xx': '#7EB26D', '4xx': '#F2C96D', '5xx': '#BF1B00' },
    pieType='donut',
    repeat='repeat_variable',
    repeatDirection='h',
    maxPerRow=5,
  )
  .addTarget({ a: 'node_load1' })
  .addTarget({ b: 'node_load15' });

local chartGaugePanel =
  gaugePanel.new(
    'Gauge Demo',
    min=10,
    max=95,
  ).addThresholds([
    { color: 'green', value: 0 },
    { color: 'yellow', value: 50 },
    { color: 'red', value: 80 },
  ])
  .addTarget({ a: 'node_load1' });

local chartGraphPanel =
  graphPanel.new(
    title='Graph Demo',
    datasource='Prometheus',
    linewidth=2,
    format='Bps',
    aliasColors={
      Rx: 'light-green',
      Tx: 'light-red',
    },
  ).addTarget(
    prometheus.target(
      'rate(node_network_receive_bytes_total[1m])',
      legendFormat='Rx',
    )
  ).addTarget(
    prometheus.target(
      'irate(node_network_transmit_bytes_total[1m]) * (-1)',
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
      dashboard.new('Chart / Single Stats', schemaVersion=18)
      .addTemplate(datasource_template)
      .addTemplate(instance_template)
      .addPanels(
        [
          chartSinglestat { gridPos: { h: 4, w: 3, x: 0, y: 0 } },
        ]
      ),
    'chart-graph.json':
      dashboard.new('Chart / Graph', schemaVersion=18)
      .addTemplate(datasource_template)
      .addTemplate(instance_template)
      .addPanels(
        [
          chartGraphPanel { gridPos: { h: 8, w: 12, x: 0, y: 0 } },
        ]
      ),
    'chart-gauge.json':
      dashboard.new('Chart / Gauge', schemaVersion=18)
      .addTemplate(datasource_template)
      .addTemplate(instance_template)
      .addPanels(
        [
          chartGaugePanel { gridPos: { h: 10, w: 10, x: 0, y: 4 } },
        ]
      ),
    'chart-piechart.json':
      dashboard.new('Chart / Pie Chart', schemaVersion=18)
      .addTemplate(datasource_template)
      .addTemplate(instance_template)
      .addPanels(
        [
          chartPieChartPanel { gridPos: { h: 10, w: 10, x: 0, y: 4 } },
        ]
      ),
  },
}
