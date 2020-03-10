require 'test_helper'

class AdminBillingControllerTest < ActionDispatch::IntegrationTest
  test "Billing orders" do
    perform_successful_login

    get '/admin/billing/orders'

    assert_response :success

    assert_includes response.parsed_body, '10'
    assert_includes response.parsed_body, 'Payments History'
  end

  test "Billing spendings" do
    perform_successful_login

    get '/admin/billing/spending'

    assert_response :success

    assert_includes response.parsed_body, '10'
  end
end
