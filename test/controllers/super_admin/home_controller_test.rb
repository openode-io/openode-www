require 'test_helper'

class SuperAdminHomeControllerTest < ActionDispatch::IntegrationTest
  test "access to super admin home" do
    perform_successful_login

    get '/super_admin'

    assert_response :found
  end
end
