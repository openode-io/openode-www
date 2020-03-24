require 'test_helper'

class SuperAdminOrdersControllerTest < ActionDispatch::IntegrationTest
  test "orders" do
    perform_successful_login

    get '/super_admin/orders'

    assert_response :success

    assert_includes response.parsed_body.to_s, 'asdf234asdfasdffds@gmaill.com'
  end
end
