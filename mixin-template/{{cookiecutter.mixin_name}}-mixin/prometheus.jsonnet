
{
  '{{cookiecutter.mixin_name}}_alerts.yml': (import 'mixin.libsonnet').prometheusAlerts,
  '{{cookiecutter.mixin_name}}_rules.yml': (import 'mixin.libsonnet').prometheusRules,
}
