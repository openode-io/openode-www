require 'test_helper'

class SuperAdminWebsitesControllerTest < ActionDispatch::IntegrationTest
  test "websites" do
    perform_successful_login

    get '/super_admin/websites'

    assert_response :success

    assert_includes response.parsed_body.to_s, 'site129.com'
  end

  test "websites/id" do
    perform_successful_login

    get '/super_admin/websites/152'

    assert_response :success
    assert_includes response.parsed_body.to_s, 'elviswongsti'
  end

  test "open source" do
    perform_successful_login

    get '/super_admin/websites/152/open_source'

    assert_response :success

    assert_includes response.parsed_body.to_s, 'Open source'
  end

  test "update open source" do
    perform_successful_login

    post '/super_admin/websites/152/open_source',
         params: {
           open_source: {
             status: 'approved',
             reason: 'reason x'
           }
         }

    assert_response :found
  end

  # /super_admin/websites/153/open_source
end
