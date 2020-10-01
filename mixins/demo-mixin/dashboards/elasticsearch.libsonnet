local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local template = grafana.template;
local singlestat = grafana.singlestat;
local graphPanel = grafana.graphPanel;
local tablePanel = grafana.tablePanel;
local pieChartPanel = grafana.pieChartPanel;
local gaugePanel = grafana.gaugePanel;
local heatmapPanel = grafana.heatmapPanel;
local prometheus = grafana.prometheus;
local elasticsearch = grafana.elasticsearch;

local tablePanelChart =
  tablePanel.new(
    'Elasticsearch Table Data',
    datasource='$ELASTICSEARCH_DS',
    styles=[
      {
        dateFormat: 'YYYY-MM-DD HH:mm:ss',
        pattern: 'time',
        type: 'date',
      },
    ],
    columns=[
      {
        text: 'time',
        value: 'time',
      },
      {
        text: 'severity',
        value: 'severity',
      },
      {
        text: 'message',
        value: 'message',
      },
    ],
    sort={
      col: 0,
      desc: true,
    }
  )
  .addTarget(
    elasticsearch.target(
      query='message: ERROR',
      timeField='time',
      metrics=[
        {
          field: 'select field',
          id: '1',
          type: 'raw_document',
        },
      ],
      bucketAggs=[
      ],
    ),
  );

local graphPanelChart =
  graphPanel.new(
    'Elasticsearch Graph Data',
    datasource='$ELASTICSEARCH_DS',
    span=10,
    format='short',
    stack=true,
    fill=10,
    min=0,
    linewidth=0,
    height='150px',
  )
  .addTarget(
    elasticsearch.target(
      query='message: ERR',
      timeField='time',
      metrics=[
        {
          id: '1',
          field: 'labels.app',
          type: 'count',
        },
      ],
      bucketAggs=[
        {
          id: '2',
          field: 'severity.keyword',
          type: 'terms',
          settings: {
            order: 'desc',
            size: '20',
            min_doc_count: 1,
            orderBy: '_term',
          },
        },
        {
          id: '3',
          field: 'time',
          type: 'date_histogram',
          settings: {
            interval: '30s',
            min_doc_count: 0,
            trimEdges: 0,
          },
        },
      ],
    ),
  );

local datasource_template = template.datasource(
  'ELASTICSEARCH_DS',
  'elasticsearch',
  'Elasticsearch',
);

{
  grafanaDashboards+:: {
    'elastic-graph.json':
      dashboard.new('Elastic / Graph', schemaVersion=18)
      .addTemplate(datasource_template)
      .addPanels(
        [
          graphPanelChart { gridPos: { h: 8, w: 12, x: 0, y: 8 } },
        ]
      ),
    'elastic-table.json':
      dashboard.new('Elastic / Table', schemaVersion=18)
      .addTemplate(datasource_template)
      .addPanels(
        [
          tablePanelChart { gridPos: { h: 8, w: 12, x: 12, y: 8 } },
        ]
      ),

  },
}
