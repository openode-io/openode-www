class SuperAdmin::WebsitesController < SuperAdminController
  def index
    search_for = params.dig(:websites_search, :search)
    @websites = api(:get, "/super_admin/websites/?search=#{search_for}")
  end
end
