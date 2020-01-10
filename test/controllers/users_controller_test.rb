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

  # test "should get process_forgot_password" do
  #  get users_process_forgot_password_url
  #  assert_response :success
  # end

  # test "should get activate" do
  #  get users_activate_url
  #  assert_response :success
  # end
end
