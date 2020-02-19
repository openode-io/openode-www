require 'test_helper'

class SuperAdminNotificationsControllerTest < ActionDispatch::IntegrationTest
  test "notifications" do
    perform_successful_login

    get '/super_admin/notifications'

    assert_response :success

    assert_includes response.parsed_body.to_s, 'GlobalNotification'
    assert_includes response.parsed_body.to_s, 'WebsiteNotification'
  end

  test "notification new" do
    perform_successful_login

    get '/super_admin/notifications/new'

    assert_response :success

    assert_includes response.parsed_body.to_s, 'GlobalNotification'
    assert_includes response.parsed_body.to_s, 'WebsiteNotification'
  end

  test "notification destroy" do
    perform_successful_login

    delete '/super_admin/notifications/8'

    assert_response :found
  end

  test "notification create" do
    perform_successful_login

    post '/super_admin/notifications/',
         params: {
           notification: {
             level: 'critical'
           }
         }

    assert_response :found
  end
end
