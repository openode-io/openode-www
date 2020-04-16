require 'test_helper'

class AdminInstanceAccessControllerTest < ActionDispatch::IntegrationTest
  test "get deployments" do
    perform_successful_login

    get "/admin/instances/#{default_instance_id}/access/deployments"

    assert_response :success

    assert_includes response.parsed_body, 'success'
    assert_includes response.parsed_body, 'failed'
    assert_includes response.parsed_body, ' ago'
  end

  test "get deployment" do
    perform_successful_login

    get "/admin/instances/#{default_instance_id}/access/deployments/1234"

    assert_response :success

    assert_includes response.parsed_body, 'Verifying allowed to deploy'
  end

  test "get activity_stream" do
    perform_successful_login

    get "/admin/instances/#{default_instance_id}/access/activity_stream"

    assert_response :success

    assert_includes response.parsed_body, 'sync-changes'
  end

  test "get status" do
    perform_successful_login

    get "/admin/instances/#{default_instance_id}/access/status"

    assert_response :success

    assert_includes response.parsed_body, 'Containers statuses'
    assert_includes response.parsed_body, '2020-04-15'
    assert_includes response.parsed_body, '1.26'
  end

  test "get event" do
    perform_successful_login

    get "/admin/instances/#{default_instance_id}/access/event/150"

    assert_response :success

    assert_includes response.parsed_body, 'sync-changes'
  end

  test "get console" do
    perform_successful_login

    get "/admin/instances/#{default_instance_id}/access/console"

    assert_response :success

    assert_includes response.parsed_body, 'Console'
  end

  test "exec console" do
    perform_successful_login

    post "/admin/instances/#{default_instance_id}/access/cmd",
         params: {
           cmd: 'df -h'
         }

    assert_response :success

    assert_includes response.parsed_body.to_s, 'output!'
  end
end
