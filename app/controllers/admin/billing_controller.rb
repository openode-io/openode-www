class Admin::BillingController < AdminController
  before_action do
    add_breadcrumb "Home",
                   admin_instances_path
    add_breadcrumb "Billing",
                   admin_billing_path
  end

  def index
    redirect_to({ action: :orders })
  end

  def orders
    add_breadcrumb "Payments History"

    @orders = api(:get, '/billing/orders')
  end

  def spending
    add_breadcrumb "Spending"
  end

  def pay
    add_breadcrumb "New Payment"

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
