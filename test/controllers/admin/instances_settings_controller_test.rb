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
              skip_port_check: "false",
              status_probe_path: "/status",
              status_probe_period: "25"
            }
          }

    assert_response :found
  end

  test "get alerts page" do
    perform_successful_login

    get "/admin/instances/#{default_instance_id}/settings/alerts"

    assert_response :success

    assert_includes response.parsed_body, 'Stop lacking credits'
  end

  test "update alerts" do
    perform_successful_login

    patch "/admin/instances/#{default_instance_id}/settings/alerts",
          params: {
            website: {
              stop_lacking_credits: '1'
            }
          }

    assert_response :found
  end

  test "get ssl page" do
    perform_successful_login

    get "/admin/instances/#{default_instance_id}/settings/ssl"

    assert_response :success

    assert_includes response.parsed_body, 'Certificate Path'
  end

  test "update ssl" do
    perform_successful_login

    patch "/admin/instances/#{default_instance_id}/settings/ssl",
          params: {
            website: {
              ssl_certificate_path: "cert/crt.crt",
              ssl_certificate_key_path: "cert/key.key"
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

  test "get env page" do
    perform_successful_login

    get "/admin/instances/#{default_instance_id}/settings/env"

    assert_response :success

    assert_includes response.parsed_body, 'Environment Variables'
    assert_includes response.parsed_body, 'TITEST'
    assert_includes response.parsed_body, 'TOTEST'
  end

  test "update env page" do
    perform_successful_login

    patch "/admin/instances/#{default_instance_id}/settings/env",
          params: {
            website: {
              variables: {
                var1: {
                  variable: 'var1',
                  value: 'val1'
                }
              }
            }
          }

    assert_response :found
  end

  # dns and alias
  test "get dns and alias" do
    perform_successful_login

    get "/admin/instances/#{default_instance_id}/settings/dns_and_aliases"

    assert_response :success
    assert_includes response.parsed_body, 'DNS And Aliases'
    assert_includes response.parsed_body, 'canada.openode.io'
    assert_includes response.parsed_body, '127.0.0.2'
  end

  test "create alias" do
    perform_successful_login

    post "/admin/instances/#{default_instance_id}/settings/aliases",
         params: {
           alias: {
             alias: 'asdf.test.com'
           }
         }

    assert_response :found
  end

  test "delete alias" do
    perform_successful_login

    delete "/admin/instances/#{default_instance_id}/settings/aliases/d3d3LmlvY2hhaW4uY28="

    assert_response :found
  end

  # plan
  test "get plan" do
    perform_successful_login

    get "/admin/instances/#{default_instance_id}/settings/plan"

    assert_response :success

    assert_includes response.parsed_body, 'Change your plan'
  end

  test "change plan non open source" do
    perform_successful_login

    patch "/admin/instances/#{default_instance_id}/settings/plan",
          params: {
            website: {
              plan: '50-MB'
            }
          }

    assert_response :found
  end

  # address
  test "get address" do
    perform_successful_login

    get "/admin/instances/#{default_instance_id}/settings/address"

    assert_response :success
  end

  test "change address" do
    perform_successful_login

    patch "/admin/instances/#{default_instance_id}/settings/address",
          params: {
            website: {
              site_name: "asdf"
            }
          }

    assert_response :found
  end

  test "change plan open source" do
    perform_successful_login

    patch "/admin/instances/#{default_instance_id}/settings/plan",
          params: {
            website: {
              plan: 'open_source',
              open_source_title: 'hello',
              open_source_description: 'desc',
              open_source_repository: 'http://google.com/'
            }
          }

    assert_response :found
  end

  # location
  test "get location" do
    perform_successful_login

    get "/admin/instances/#{default_instance_id}/settings/location"

    assert_response :success

    assert_includes response.parsed_body, 'Change Location'
  end

  test "change location" do
    perform_successful_login

    patch "/admin/instances/#{default_instance_id}/settings/location",
          params: {
            website: {
              location_str_id: 'canada'
            }
          }

    assert_response :found
  end

  # addons
  test "new addon" do
    perform_successful_login

    get "/admin/instances/#{default_instance_id}/settings/addons/new"

    assert_response :success

    assert_includes response.parsed_body, 'memcached'
    assert_includes response.parsed_body, 'redis-caching'
  end

  test "create addon" do
    perform_successful_login

    post "/admin/instances/#{default_instance_id}/settings/addons/",
         params: {
           addon: {
             addon_id: 1234
           }
         }

    assert_response :found
  end

  test "edit addon" do
    perform_successful_login

    get "/admin/instances/#{default_instance_id}/settings/addons/7"

    assert_response :success

    assert_includes response.parsed_body, 'memcached2'
    assert_includes response.parsed_body, '50MB Memory'
    assert_includes response.parsed_body, '11212'
  end

  test "update addon" do
    perform_successful_login

    patch "/admin/instances/#{default_instance_id}/settings/addons/7",
          params: {
            addon: {
              name: 'titi'
            }
          }

    assert_response :found
  end

  test "update addon with newline" do
    perform_successful_login

    patch "/admin/instances/#{default_instance_id}/settings/addons/7",
          params: {
            addon: {
              name: 'titi\n'
            }
          }

    assert_response :found
  end
end
