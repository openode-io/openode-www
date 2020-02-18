require 'test_helper'

class SuperAdminNewslettersControllerTest < ActionDispatch::IntegrationTest
  test "newsletters" do
    perform_successful_login

    get '/super_admin/newsletters'

    assert_response :success

    assert_includes response.parsed_body.to_s, '<h1>Newsletters</h1>'
    assert_includes response.parsed_body.to_s, 'hi world.'
  end
end
