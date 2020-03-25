class SuperAdmin::HomeController < SuperAdminController
  def index
    redirect_to '/super_admin/stats'
  end
end
