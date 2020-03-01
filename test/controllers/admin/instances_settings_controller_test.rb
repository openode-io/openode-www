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
end
