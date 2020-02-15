class SuperAdmin::UsersController < SuperAdminController
  def index
    search_for = params.dig(:users_search, :search)
    @users = api(:get, "/super_admin/users/?search=#{search_for}")
  end
end
