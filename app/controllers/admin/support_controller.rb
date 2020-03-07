class Admin::SupportController < AdminController
  def index
    instances = api(:get, "/instances/")
    @account = api(:get, "/account/me")

    @instances_list = instances.map { |i| [i['site_name'], i['site_name']] }
  end
end
