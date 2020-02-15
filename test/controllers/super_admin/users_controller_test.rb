require 'test_helper'

class SuperAdminUsersControllerTest < ActionDispatch::IntegrationTest
  test "users" do
    perform_successful_login

    get '/super_admin/users'

    assert_response :success

    assert_includes response.parsed_body.to_s, 'asdfffasdf223@gmail.com'
  end
end
