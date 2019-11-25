
{
  'kube_rules.yml': (import 'kubernetes-mixin/mixin.libsonnet').prometheusRules,
  'kube_alerts.yml': (import 'kubernetes-mixin/mixin.libsonnet').prometheusAlerts
}
