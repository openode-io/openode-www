require 'test_helper'

class SuperAdminUsersControllerTest < ActionDispatch::IntegrationTest
  test "users" do
    perform_successful_login

    get '/super_admin/users'

    assert_response :success

    assert_includes response.parsed_body.to_s, 'asdfffasdf223@gmail.com'
  end

  test "custom_order" do
    perform_successful_login

    get '/super_admin/users/83/custom_order'

    assert_response :success

    assert_includes response.parsed_body.to_s, 'Order for user id 83'
  end

  test "make_order" do
    perform_successful_login

    post '/super_admin/users/83/custom_order',
         params: {
           order: {
             amount: '34.43',
             gateway: 'btc',
             reason: 'cool',
             user_id: '83',
             payment_status: 'Completed'
           }
         }

    assert_response :found
  end
end
