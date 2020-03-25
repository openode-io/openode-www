class SuperAdmin::StatsController < SuperAdminController
  def index
    @spendings = api(:get, "/super_admin/stats/spendings")
  end
end
