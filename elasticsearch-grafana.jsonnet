local dashboards = (import 'elasticsearch-mixin/mixin.libsonnet').grafanaDashboards;

{
  [name]: dashboards[name]
  for name in std.objectFields(dashboards)
}
