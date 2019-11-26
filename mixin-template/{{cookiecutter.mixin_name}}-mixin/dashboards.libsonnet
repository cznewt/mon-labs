local g = import 'grafana-builder/grafana.libsonnet';
{
  grafanaDashboards+:: {
    '{{cookiecutter.mixin_name}}.json':
      g.dashboard('{{cookiecutter.mixin_name|capitalize}} Service')
      .addTemplate('instance', 'param_query', 'instance')
  },
}
