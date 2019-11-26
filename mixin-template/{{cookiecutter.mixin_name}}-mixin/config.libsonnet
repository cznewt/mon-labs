{
  _config+:: {
    // Placed inside {} in prometheus queries
    {{cookiecutter.mixin_name}}_selector: 'name="{{cookiecutter.mixin_name}}"',

  },
}
