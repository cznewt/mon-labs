
{
  'node_rules.yml': (import 'node-mixin/mixin.libsonnet').prometheusRules,
  'node_alerts.yml': (import 'node-mixin/mixin.libsonnet').prometheusAlerts
}
