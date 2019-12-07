require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get register" do
    get users_register_url
    assert_response :success
  end

  # test "should get create" do
  #  get users_create_url
  #  assert_response :success
  # end

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
