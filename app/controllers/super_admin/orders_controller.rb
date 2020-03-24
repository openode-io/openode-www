class SuperAdmin::OrdersController < SuperAdminController
  def index
    search_for = params.dig(:orders_search, :search)
    @orders = api(:get, "/super_admin/orders/?search=#{search_for}")
  end
end
