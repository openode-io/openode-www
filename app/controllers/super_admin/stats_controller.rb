class SuperAdmin::StatsController < SuperAdminController
  def index
    @spendings = api(:get, "/super_admin/stats/spendings")
    @nb_online_stats = api(:get, "/super_admin/stats/nb_online")
  end
end
