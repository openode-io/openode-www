class SuperAdmin::HomeController < SuperAdminController
  def index
    redirect_to '/super_admin/stats'
  end

  def deployments
    @deployments = api(:get,
                       "/super_admin/generic/Deployment?entity_method=type_dep&search=")
  end
end
