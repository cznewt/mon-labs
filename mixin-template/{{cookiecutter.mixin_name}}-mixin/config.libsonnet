{
  _config+:: {
    // Placed inside {} in prometheus queries
    {{cookiecutter.mixin_name}}Selector: 'name="{{cookiecutter.mixin_name}}"',

    grafanaDashboardIDs+: {
      '{{cookiecutter.mixin_name}}.json': '{{cookiecutter.mixin_name}}',
    },

  },
}
