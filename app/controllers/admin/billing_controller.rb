class Admin::BillingController < AdminController
  before_action do
    add_breadcrumb "Home",
                   admin_instances_path
    add_breadcrumb "Billing",
                   admin_billing_path
  end

  def index
    redirect_to(action: :subscription)
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
        addr: '3HW6gpLrgr2ypGi5Rj37pZQrkd3ZJfgBZY'
      },
      {
        id: 'ether',
        addr: '0x79d2d008b495915cc2c334ba7d5c4143a52a9161'
      },
      {
        id: 'litecoin',
        addr: 'MV1rA12f6w8LSkxpGBnmhYmL28MWXvrQU8'
      },
      {
        id: 'chainlink',
        addr: '0x79d2d008b495915cc2c334ba7d5c4143a52a9161'
      },
      {
        id: 'pax-gold',
        addr: '0x79d2d008b495915cc2c334ba7d5c4143a52a9161'
      },
      {
        id: 'tether',
        addr: '0x79d2d008b495915cc2c334ba7d5c4143a52a9161'
      }
    ]
  end
end
