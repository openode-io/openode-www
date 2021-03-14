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

  test "rollback a deployment" do
    perform_successful_login

    post "/admin/instances/#{default_instance_id}/" \
          "access/deployments/1234/rollback"

    assert_response :found
  end

  test "get snapshots" do
    perform_successful_login

    get "/admin/instances/#{default_instance_id}/access/snapshots"

    assert_response :success

    assert_includes response.parsed_body, 'Snapshots'
  end

  test "create snapshot" do
    perform_successful_login

    post "/admin/instances/#{default_instance_id}/access/snapshots",
         params: {
           website: {
             path: '/var/www/',
             app: 'www'
           }
         }

    assert_response :found
  end

  test "list snapshots" do
    perform_successful_login

    get "/admin/instances/#{default_instance_id}/access/list-snapshots"

    assert_response :success
    assert_includes response.parsed_body, 'succeed'
  end

  test "get snapshot" do
    perform_successful_login

    get "/admin/instances/#{default_instance_id}/access/snapshots/1234"

    assert_response :success
    assert_includes response.parsed_body, 'succeed'
    assert_includes response.parsed_body, '1234'
  end

  test "deploy" do
    perform_successful_login

    get "/admin/instances/#{default_instance_id}/access/deploy"

    assert_response :success
    assert_includes response.parsed_body, 'We have several ways to deploy'
  end

  test "do deploy" do
    perform_successful_login

    post "/admin/instances/#{default_instance_id}/access/deploy",
         params: {
           website: {
             repository_url: 'https://google.com'
           }
         }

    assert_response :found
  end

  test "get logs" do
    perform_successful_login

    get "/admin/instances/#{default_instance_id}/access/logs"

    assert_response :success

    assert_includes response.parsed_body, 'hello logs'
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
