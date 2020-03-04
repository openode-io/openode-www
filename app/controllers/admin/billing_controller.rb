class Admin::BillingController < AdminController
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
    add_breadcrumb "Payments History"

    @orders = api(:get, '/billing/orders')
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
end
