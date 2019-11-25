local dashboards = (import 'nasa-swpc-mixin/mixin.libsonnet').grafanaDashboards;

{
  [name]: dashboards[name]
  for name in std.objectFields(dashboards)
}
