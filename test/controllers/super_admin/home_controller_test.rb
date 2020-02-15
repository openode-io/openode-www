require 'test_helper'

class SuperAdminHomeControllerTest < ActionDispatch::IntegrationTest
  test "access to super admin home" do
    perform_successful_login

    get '/super_admin'

    assert_response :success

    assert_includes response.parsed_body.to_s, 'Welcome to the super admin area'
  end
end
