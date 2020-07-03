class SuperAdmin::StatsController < SuperAdminController
  def index
    @spendings = api(:get, "/super_admin/stats/spendings")
    @nb_online_stats = api(:get, "/super_admin/stats/nb_online")
    @deployments = api(:get, "/super_admin/stats/generic_daily_stats?attrib_to_sum=1" \
                              "&entity=Deployment&entity_method=type_dep")
  end
end
