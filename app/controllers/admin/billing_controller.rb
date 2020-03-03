class Admin::BillingController < AdminController
  before_action :set_order, only: [:index, :orders]

  def index
    add_breadcrumb "Home",
                   admin_instances_path
    add_breadcrumb "Billing"
  end

  def orders
    add_breadcrumb "Home",
                   admin_instances_path
    add_breadcrumb "Billing",
                   admin_billing_path
    add_breadcrumb "Payment History"
  end

  def spending
    add_breadcrumb "Home",
                   admin_instances_path
    add_breadcrumb "Billing",
                   admin_billing_path
    add_breadcrumb "Spending"
  end

  def pay
    add_breadcrumb "Home",
                   admin_instances_path
    add_breadcrumb "Billing",
                   admin_billing_path
    add_breadcrumb "New Payment"

    @cryptos = %w[bitcoin ether ripple bitcoin-cash]
  end

  private

  def set_order
    @orders = [
      {
        id: 12,
        amount: "$74.10",
        date: "Feb 28, 2020"
      },
      {
        id: 8,
        amount: "$174.35",
        date: "Feb 20, 2020"
      }
    ]
  end
end
