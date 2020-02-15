require 'test_helper'

class SuperAdminWebsitesControllerTest < ActionDispatch::IntegrationTest
  test "websites" do
    perform_successful_login

    get '/super_admin/websites'

    assert_response :success

    assert_includes response.parsed_body.to_s, 'site129.com'
  end
end
