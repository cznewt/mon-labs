{
  prometheusAlerts+:: {
    groups+: [
      {
        name: '{{cookiecutter.mixin_name}}',
        rules: []
      }
    ]
  }
}