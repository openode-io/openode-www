require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get register" do
    get users_register_url
    assert_response :success
  end

  test "should get create  - happy path" do
    post '/users',
         params: {
           account: {
             email: "myadminvalidregister@thisisit.com",
             password: "Helloworld234",
             password_confirmation: "Helloworld234",
             newsletter: 0
           }
         }

    assert_equal session["token"], "15487ca02fa4f928be9f8c2dfb1115d5"
  end

  test "should get create  - validation issue" do
    post '/users',
         params: {
           account: {
             email: "myadminvalidregister@thisisit.com",
             password: "Helloworld234",
             password_confirmation: "Helloworld234567"
           }
         },
         as: :json

    assert_response :unprocessable_entity

    assert_includes response.parsed_body['error'], 'does not match'
  end

  test "should get forgot_password" do
    get users_forgot_password_url
    assert_response :success
  end

  test "forgot password page" do
    get '/users/forgot_password'

    assert_response :success
    assert_includes response.parsed_body, 'Password Recovery'
  end

  test "forgot password - process" do
    post '/users/forgot_password',
         params: {
           email: 'titi@toto.com'
         }

    assert_response :redirect
  end

  test "reset token" do
    get '/reset/theresettoken'

    assert_response :redirect
  end
end
