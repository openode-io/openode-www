class Admin::BillingController < AdminController
  before_action do
    add_breadcrumb "Home",
                   admin_instances_path
    add_breadcrumb "Billing",
                   admin_billing_path
  end

  before_action :prepare_pay, only: [:pay, :paypal, :crypto]

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
  end

  def paypal
  end

  def crypto
    @cryptos = [
      {
        id: 'bitcoin',
        addr: '35MHiUfGB1ZGAPi4ejdcuuhMqXUxv2tpK7',
        qr_path: '/images/billing/crypto/qr_bitcoin.png'
      },
      {
        id: 'cro',
        addr: 'cro1w2kvwrzp23aq54n3amwav4yy4a9ahq2kz2wtmj',
        memo: '851070363',
        logo_path: '/images/billing/crypto/cro.svg'
      }
    ]
  end


  def request_crypto_payment
    api(:post,
      "/billing/request_payment",
      payload: {
        token: params["crypto"]["token"],
        amount: params["crypto"]["amount"]
      }
    )

    redirect_to({ action: :pay },
                notice: "Thanks for your payment! It will be processed shortly.")
  end

  private

  def prepare_pay
    add_breadcrumb "On Demand Payment"

    @user = api(:get, "/account/me")
  end
end
