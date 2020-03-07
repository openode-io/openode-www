require 'test_helper'

class AdminInstanceSettingsControllerTest < ActionDispatch::IntegrationTest
  test "get misc page" do
    perform_successful_login

    get "/admin/instances/#{default_instance_id}/settings/misc"

    assert_response :success

    assert_includes response.parsed_body, 'Maximum deployment duration'
  end

  test "update misc" do
    perform_successful_login

    patch "/admin/instances/#{default_instance_id}/settings/misc",
          params: {
            website: {
              max_build_duration: "112",
              skip_port_check: "false"
            }
          }

    assert_response :found
  end

  test "get scheduler page" do
    perform_successful_login

    get "/admin/instances/#{default_instance_id}/settings/scheduler"

    assert_response :success

    assert_includes response.parsed_body, 'The scheduler allows'
  end

  test "update scheduler" do
    perform_successful_login

    patch "/admin/instances/#{default_instance_id}/settings/scheduler",
          params: {
            website: {
              crontab: "* * * * * ls"
            }
          }

    assert_response :found
  end

  test "get persistence" do
    perform_successful_login

    get "/admin/instances/#{default_instance_id}/settings/persistence"

    assert_response :success

    assert_includes response.parsed_body, 'Storage Area'
  end

  test "destroy persistence" do
    perform_successful_login

    delete "/admin/instances/#{default_instance_id}/settings/persistence"

    assert_response :found
  end

  test "change size" do
    perform_successful_login

    patch "/admin/instances/#{default_instance_id}/settings/change_size",
          params: {
            persistence: {
              amount_gb: 3
            }
          }

    assert_response :found
  end
end
