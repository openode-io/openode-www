require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "get admin dashboard" do
    perform_successful_login

    get '/admin'

    assert_response :success
    assert_includes response.parsed_body.to_s, 'Dashboard'
  end

  test "get admin instances" do
    perform_successful_login

    get '/admin/instances'

    assert_response :success
    assert_includes response.parsed_body.to_s, 'Instances'
  end

  test "get admin billing payments" do
    perform_successful_login

    get '/admin/billing'

    assert_response :success
    assert_includes response.parsed_body.to_s, 'Payments'
  end

  test "get admin billing orders" do
    perform_successful_login

    get '/admin/billing/orders'

    assert_response :success
    assert_includes response.parsed_body.to_s, 'Order'
  end

  test "get admin account profile settings" do
    perform_successful_login

    get '/admin/profile'

    assert_response :success
    assert_includes response.parsed_body.to_s, 'Profile'
  end

  test "get admin account notification settings" do
    perform_successful_login

    get '/admin/notifications'

    assert_response :success
    assert_includes response.parsed_body.to_s, 'Notification'
  end

  test "get admin account API settings" do
    perform_successful_login

    get '/admin/api'

    assert_response :success
    assert_includes response.parsed_body.to_s, 'API'
  end

  test "get admin account newsletter settings" do
    perform_successful_login
    
    get '/admin/api'

    assert_response :success
    assert_includes response.parsed_body.to_s, 'Newsletter'
  end
end
