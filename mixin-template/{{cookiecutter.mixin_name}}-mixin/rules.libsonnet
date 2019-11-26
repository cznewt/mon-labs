{
  prometheusRules+:: {
    groups+: [
      {
        name: '{{cookiecutter.mixin_name}}.rules',
        rules: []
      }
    ]
  }
}