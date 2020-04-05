class SuperAdmin::UsersController < SuperAdminController
  def index
    search_for = params.dig(:users_search, :search)
    @users = api(:get, "/super_admin/users/?search=#{search_for}")
  end

  def custom_order
    @user_id = params['id']
    @gateways = [
      %w[credit credit],
      %w[paypal paypal],
      %w[btc btc],
      %w[ether ether],
      %w[bch bch],
      %w[stellar stellar]
    ]
  end

  def make_order
    api(:post, "/super_admin/orders", payload: order_params)

    redirect_to({ controller: 'super_admin/home' }, notice: "Created!")
  end

  def order_params
    params.require(:order).permit(:amount, :gateway, :reason, :user_id, :payment_status)
  end
end
