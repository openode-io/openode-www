class Admin::BillingController < AdminController
  before_action do
    add_breadcrumb "Home",
                   admin_instances_path
    add_breadcrumb "Billing",
                   admin_billing_path
  end

  def index
    redirect_to(action: :pay)
  end

  def orders
    add_breadcrumb "Payments History"

    @orders = api(:get, '/billing/orders')
  end

  def spending
    add_breadcrumb "Spending"

    @spendings = api(:get, "/account/spendings")
  end

  def subscription
    add_breadcrumb "Subscription"

    @user = api(:get, "/account/me")
    @subscriptions = api(:get, "/account/subscriptions")
  end

  def cancel_subscription
    subscription_id = params[:id]
    api(:post, "/account/subscriptions/#{subscription_id}/cancel")

    notice = "The subscription has been canceled, it will be updated momentarily."
    redirect_to({ action: :subscription },
                notice: notice)
  end

  def pay
    add_breadcrumb "On Demand Payment"

    @user = api(:get, "/account/me")

    @cryptos = [
      {
        id: 'bitcoin',
        addr: '1Keimw1ojP4peMHEoPgkVZEu7J73t3uiud'
      },
      {
        id: 'ether',
        addr: '0x75718376db04A75457fc2573dAa0792f875fE441'
      },
      {
        id: 'bitcoin-cash',
        addr: 'qzz4x4qe6p0h376k6e7htzt3hexwfl683c3rqxtahf'
      },
      {
        id: 'stellar',
        addr: 'GB4NKHR56J6L4QG424S3MFHJYKTQMH4SB5IHBDEMTXS6PIJ3CZJGANWR'
      }
    ]
  end
end
