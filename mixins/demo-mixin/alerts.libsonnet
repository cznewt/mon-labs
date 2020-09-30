{
  prometheusAlerts+:: {
    groups+: [
      {
        name: 'demo',
        rules: [
          {
            alert: 'NodeLoadHigh',
            expr: |||
              instance:node_load1_per_cpu:ratio > 1
            |||,
            'for': '30m',
            labels: {
              severity: 'warning',
            },
            annotations: {
              summary: 'Node has too high load.',
              description: 'Node {{ $labels.instance }} has load {{ $value }} for more than 30 minutes.',
            },
          },
          {
            alert: 'NodeLoadHigh',
            expr: |||
              instance:node_load1_per_cpu:ratio > 2
            |||,
            'for': '1h',
            labels: {
              severity: 'critical',
            },
            annotations: {
              summary: 'Node has too high load.',
              description: 'Node {{ $labels.instance }} has load {{ $value }} for more than 30 minutes.',
            },
          },
        ],
      },
    ],
  },
}
