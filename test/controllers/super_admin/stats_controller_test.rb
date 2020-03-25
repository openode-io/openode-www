require 'test_helper'

class SuperAdminStatsControllerTest < ActionDispatch::IntegrationTest
  test "stats" do
    perform_successful_login

    get '/super_admin/stats'

    assert_response :success
  end
end
