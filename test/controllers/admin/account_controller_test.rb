require 'test_helper'

class AdminAccountControllerTest < ActionDispatch::IntegrationTest
  test "api access" do
    perform_successful_login

    get '/admin/account/api_access'

    assert_response :success
  end

  test "regen token" do
    perform_successful_login

    post '/admin/account/regenerate_token'

    assert_response :found
  end

  test "get notifications and newsletter" do
    perform_successful_login

    get '/admin/account/notifications_and_newsletter'

    assert_response :success

    assert_includes response.parsed_body, 'Notifications'
  end

  test "change notifications and newsletter" do
    perform_successful_login

    patch '/admin/account/notifications_and_newsletter',
          params: {
            user: {
              nb_credits_threshold_notification: 50,
              newsletter: 1
            }
          }

    assert_response :found
  end

  test "save profile" do
    perform_successful_login

    patch '/admin/account/',
          params: {
            user: {
              email: 'asdf@gmail.com',
              account: {
                name: 'asdf'
              }
            }
          }

    assert_response :found
  end

  test "change password" do
    perform_successful_login

    patch '/admin/account/password',
          params: {
            user: {
              password: 'Passwddd112',
              password_confirmation: 'Passwddd112'
            }
          }

    assert_response :found
  end
end
