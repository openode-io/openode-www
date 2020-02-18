class SuperAdmin::NewslettersController < SuperAdminController
  def index
    search_for = params.dig(:newsletters_search, :search)
    @newsletters = api(:get, "/super_admin/newsletters/?search=#{search_for}")
  end
end
