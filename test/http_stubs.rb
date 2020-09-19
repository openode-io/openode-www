
module HttpStubs
  def self.default_get(url, response_file, logged_in_user_token)
    {
      url: url,
      method: :get,
      with: {
        body: {}
      },
      content_type: 'application/json',
      response_status: 200,
      response_path: response_file,
      headers: {
        'X-Auth-Token' => logged_in_user_token
      }
    }
  end

  def self.default_delete(url, response_file, logged_in_user_token)
    {
      url: url,
      method: :delete,
      with: {
        body: {}
      },
      content_type: 'application/json',
      response_status: 200,
      response_path: response_file,
      headers: {
        'X-Auth-Token' => logged_in_user_token
      }
    }
  end

  def self.default_with_body(method_type, url, body, response_file, logged_in_user_token)
    {
      url: url,
      method: method_type,
      with: {
        body: body
      },
      content_type: 'application/json',
      response_status: 200,
      response_path: response_file,
      headers: {
        'X-Auth-Token' => logged_in_user_token
      }
    }
  end

  def self.default_patch(url, body, response_file, logged_in_user_token)
    HttpStubs.default_with_body(:patch, url, body, response_file, logged_in_user_token)
  end

  def self.default_post(url, body, response_file, logged_in_user_token)
    HttpStubs.default_with_body(:post, url, body, response_file, logged_in_user_token)
  end

  def self.default_put(url, body, response_file, logged_in_user_token)
    HttpStubs.default_with_body(:put, url, body, response_file, logged_in_user_token)
  end

  def self.all(logged_in_user_token)
    [
      {
        url: 'https://api.openode.io/account/getToken',
        method: :post,
        with: {
          body: { 'email' => 'mymail@openode.io', 'password' => '1234561!' }
        },
        content_type: 'application/json',
        response_status: 200,
        response_path: 'test/fixtures/http/openode_api/front/get_token_exists.json'
      },
      {
        url: 'https://api.openode.io/account/getToken',
        method: :post,
        with: {
          body: { 'email' => 'superadmin@openode.io', 'password' => '1234561!' }
        },
        content_type: 'application/json',
        response_status: 200,
        response_path: 'test/fixtures/http/openode_api/front/get_super_admin_token.json'
      },
      {
        url: 'https://api.openode.io/account/getToken',
        method: :post,
        with: {
          body: { 'email' => 'invalid@openode.io', 'password' => '123456' }
        },
        content_type: 'application/json',
        response_status: 404,
        response_path: 'test/fixtures/http/openode_api/front/get_token_not_exists.json'
      },
      {
        url: 'https://api.openode.io/account/register',
        method: :post,
        with: {
          body: {
            account: {
              'email' => 'myadminvalidregister@thisisit.com',
              'password' => 'Helloworld234',
              'password_confirmation' => 'Helloworld234',
              'newsletter' => '0'
            }
          }
        },
        content_type: 'application/json',
        response_status: 200,
        response_path: 'test/fixtures/http/openode_api/front/users_create.json'
      },
      {
        url: 'https://api.openode.io/account/register',
        method: :post,
        with: {
          body: {
            account: {
              'email' => 'myadminvalidregister@thisisit.com',
              'password' => 'Helloworld234',
              'password_confirmation' => 'Helloworld234567'
            }
          }
        },
        content_type: 'application/json',
        response_status: 422,
        response_path:
          'test/fixtures/http/openode_api/front/users_create_validation_issue.json'
      },
      {
        url: 'https://api.openode.io/global/stats',
        method: :get,
        with: {
          body: {}
        },
        content_type: 'application/json',
        response_status: 200,
        response_path:
          'test/fixtures/http/openode_api/front/global_stats.json'
      },
      {
        url: 'https://api.openode.io/account/forgot-password',
        method: :post,
        with: {
          body: {}
        },
        content_type: 'application/json',
        response_status: 200,
        response_path:
          'test/fixtures/http/openode_api/front/forgot-password.json'
      },
      {
        url: 'https://api.openode.io/account/verify-reset-token',
        method: :post,
        with: {
          body: {
            "reset_token" => "theresettoken"
          }
        },
        content_type: 'application/json',
        response_status: 200,
        response_path:
          'test/fixtures/http/openode_api/front/forgot-password.json'
      },
      {
        url: 'https://api.openode.io/open_source_projects/latest',
        method: :get,
        with: {
          body: {}
        },
        content_type: 'application/json',
        response_status: 200,
        response_path:
          'test/fixtures/http/openode_api/front/open_source_projects_latest.json'
      },
      {
        url: 'https://api.openode.io/open_source_project/test1234568',
        method: :get,
        with: {
          body: {}
        },
        content_type: 'application/json',
        response_status: 200,
        response_path:
          'test/fixtures/http/openode_api/front/open_source_project_test1234568.json'
      },
      {
        url: 'https://api.openode.io/super_admin/support/contact',
        method: :post,
        with: {
          body: {
            "email" => "hello@world.com",
            "message" => "im interested"
          }
        },
        content_type: 'application/json',
        response_status: 200,
        response_path:
          'test/fixtures/http/openode_api/front/support-contact.json',
        headers: {
          'X-Auth-Token' => logged_in_user_token
        }
      },
      {
        url: 'https://api.openode.io/notifications/?limit=5',
        method: :get,
        with: {
          body: {}
        },
        content_type: 'application/json',
        response_status: 200,
        response_path:
          'test/fixtures/http/openode_api/admin/dropdown-notifications.json',
        headers: {
          'X-Auth-Token' => logged_in_user_token
        }
      },
      {
        url: 'https://api.openode.io/notifications/?limit=1&types=GlobalNotification',
        method: :get,
        with: {
          body: {}
        },
        content_type: 'application/json',
        response_status: 200,
        response_path:
          'test/fixtures/http/openode_api/admin/latest-global-notifications.json',
        headers: {
          'X-Auth-Token' => logged_in_user_token
        }
      },
      {
        url: 'https://api.openode.io/instances/summary',
        method: :get,
        with: {
          body: {}
        },
        content_type: 'application/json',
        response_status: 200,
        response_path:
          'test/fixtures/http/openode_api/admin/instances-summary.json',
        headers: {
          'X-Auth-Token' => logged_in_user_token
        }
      },
      {
        url: 'https://api.openode.io/global/available-plans',
        method: :get,
        with: {
          body: {}
        },
        content_type: 'application/json',
        response_status: 200,
        response_path:
          'test/fixtures/http/openode_api/admin/available-plans.json',
        headers: {
          'X-Auth-Token' => logged_in_user_token
        }
      },
      {
        url: 'https://api.openode.io/global/available-locations?type=kubernetes',
        method: :get,
        with: {
          body: {}
        },
        content_type: 'application/json',
        response_status: 200,
        response_path:
          'test/fixtures/http/openode_api/admin/available-locations.json',
        headers: {
          'X-Auth-Token' => logged_in_user_token
        }
      },
      {
        url: 'https://api.openode.io/global/available-locations',
        method: :get,
        with: {
          body: {}
        },
        content_type: 'application/json',
        response_status: 200,
        response_path:
          'test/fixtures/http/openode_api/admin/available-locations.json',
        headers: {
          'X-Auth-Token' => logged_in_user_token
        }
      },
      HttpStubs.default_get(
        'https://api.openode.io/instances/152/locations',
        'test/fixtures/http/openode_api/admin/instance_locations.json',
        logged_in_user_token
      ),
      HttpStubs.default_post('https://api.openode.io/instances/152/remove-location',
                             { "location_str_id" => "canada" },
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_post('https://api.openode.io/instances/152/add-location',
                             { "location_str_id" => "canada" },
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      {
        url: 'https://api.openode.io/instances/create',
        method: :post,
        with: {
          body: { "account_type" => "subdomain" }
        },
        content_type: 'application/json',
        response_status: 200,
        response_path:
          'test/fixtures/http/openode_api/admin/create-instance.json',
        headers: {
          'X-Auth-Token' => logged_in_user_token
        }
      },
      {
        url: 'https://api.openode.io/account/me',
        method: :get,
        with: {
          body: {}
        },
        content_type: 'application/json',
        response_status: 200,
        response_path:
          'test/fixtures/http/openode_api/front/me.json',
        headers: {
          'X-Auth-Token' => logged_in_user_token
        }
      },
      {
        url: 'https://api.openode.io/super_admin/websites/?search=',
        method: :get,
        with: {
          body: {}
        },
        content_type: 'application/json',
        response_status: 200,
        response_path:
          'test/fixtures/http/openode_api/super_admin/get_websites.json',
        headers: {
          'X-Auth-Token' => logged_in_user_token
        }
      },
      {
        url: 'https://api.openode.io/super_admin/users/?search=',
        method: :get,
        with: {
          body: {}
        },
        content_type: 'application/json',
        response_status: 200,
        response_path:
          'test/fixtures/http/openode_api/super_admin/get_users.json',
        headers: {
          'X-Auth-Token' => logged_in_user_token
        }
      },
      {
        url: 'https://api.openode.io/super_admin/orders',
        method: :post,
        with: {
          body: {
            "amount" => "34.43", "gateway" => "btc",
            "payment_status" => "Completed", "reason" => "cool",
            "user_id" => "83"
          }
        },
        content_type: 'application/json',
        response_status: 200,
        response_path:
          'test/fixtures/http/openode_api/super_admin/make_order_success.json',
        headers: {
          'X-Auth-Token' => logged_in_user_token
        }
      },
      {
        url: 'https://api.openode.io/notifications/all?search=',
        method: :get,
        with: {
          body: {}
        },
        content_type: 'application/json',
        response_status: 200,
        response_path:
          'test/fixtures/http/openode_api/super_admin/get_notifications.json',
        headers: {
          'X-Auth-Token' => logged_in_user_token
        }
      },
      {
        url: 'https://api.openode.io/notifications/8',
        method: :delete,
        with: {
          body: {}
        },
        content_type: 'application/json',
        response_status: 200,
        response_path:
          'test/fixtures/http/openode_api/super_admin/delete_notification.json',
        headers: {
          'X-Auth-Token' => logged_in_user_token
        }
      },
      {
        url: 'https://api.openode.io/notifications/',
        method: :post,
        with: {
          body: { "notification" => { "level" => "critical" } }
        },
        content_type: 'application/json',
        response_status: 200,
        response_path:
          'test/fixtures/http/openode_api/super_admin/create_notification.json',
        headers: {
          'X-Auth-Token' => logged_in_user_token
        }
      },
      {
        url: 'https://api.openode.io/notifications/?limit=100',
        method: :get,
        with: {
          body: {}
        },
        content_type: 'application/json',
        response_status: 200,
        response_path:
          'test/fixtures/http/openode_api/admin/latest_notifications.json',
        headers: {
          'X-Auth-Token' => logged_in_user_token
        }
      },
      {
        url: 'https://api.openode.io/notifications/view?all=true',
        method: :post,
        with: {
          body: {}
        },
        content_type: 'application/json',
        response_status: 200,
        response_path:
          'test/fixtures/http/openode_api/empty_object.json',
        headers: {
          'X-Auth-Token' => logged_in_user_token
        }
      },
      {
        url: 'https://api.openode.io/super_admin/newsletters/?search=',
        method: :get,
        with: {
          body: {}
        },
        content_type: 'application/json',
        response_status: 200,
        response_path:
          'test/fixtures/http/openode_api/super_admin/get_newsletters.json',
        headers: {
          'X-Auth-Token' => logged_in_user_token
        }
      },
      {
        url: 'https://api.openode.io/super_admin/newsletters/1/send',
        method: :post,
        with: {
          body: {}
        },
        content_type: 'application/json',
        response_status: 200,
        response_path:
          'test/fixtures/http/openode_api/empty_object.json',
        headers: {
          'X-Auth-Token' => logged_in_user_token
        }
      },
      {
        url: 'https://api.openode.io/super_admin/newsletters/',
        method: :post,
        with: {
          body: {}
        },
        content_type: 'application/json',
        response_status: 200,
        response_path:
          'test/fixtures/http/openode_api/empty_object.json',
        headers: {
          'X-Auth-Token' => logged_in_user_token
        }
      },
      HttpStubs.default_get('https://api.openode.io/instances/152/collaborators',
                            'test/fixtures/http/openode_api/admin/get_collaborators.json',
                            logged_in_user_token),
      {
        url: 'https://api.openode.io/instances/152/collaborators',
        method: :post,
        with: {
          body: {}
        },
        content_type: 'application/json',
        response_status: 200,
        response_path:
          'test/fixtures/http/openode_api/empty_object.json',
        headers: {
          'X-Auth-Token' => logged_in_user_token
        }
      },
      HttpStubs.default_get('https://api.openode.io/instances/152',
                            'test/fixtures/http/openode_api/admin/get_instance_152.json',
                            logged_in_user_token),
      HttpStubs.default_post('https://api.openode.io/instances/152/set-config',
                             { "value" => "112", "variable" => "MAX_BUILD_DURATION" },
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_post('https://api.openode.io/instances/152/set-config',
                             {
                               "value" => "false",
                               "variable" => "BLUE_GREEN_DEPLOYMENT"
                             },
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_post('https://api.openode.io/instances/152/set-config',
                             {
                               "value" => "2",
                               "variable" => "REPLICAS"
                             },
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_post('https://api.openode.io/instances/152/set-config',
                             {
                               "value" => "0",
                               "variable" => "REPLICAS"
                             },
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_post('https://api.openode.io/instances/152/set-config',
                             { "value" => "/status", "variable" => "STATUS_PROBE_PATH" },
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_post('https://api.openode.io/instances/152/set-config',
                             { "value" => "25", "variable" => "STATUS_PROBE_PERIOD" },
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_post('https://api.openode.io/instances/152/set-config',
                             { "value" => "false", "variable" => "SKIP_PORT_CHECK" },
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_patch('https://api.openode.io/instances/152',
                              { "website" => { "crontab" => "* * * * * ls" } },
                              'test/fixtures/http/openode_api/empty_object.json',
                              logged_in_user_token),
      HttpStubs.default_get('https://api.openode.io/billing/orders',
                            'test/fixtures/http/openode_api/admin/get_orders.json',
                            logged_in_user_token),
      HttpStubs.default_get('https://api.openode.io/instances/152/executions/list/Deployment',
                            'test/fixtures/http/openode_api/admin/get_deployments.json',
                            logged_in_user_token),
      HttpStubs.default_post('https://api.openode.io/instances/152/restart?parent_execution_id=1234',
                             {},
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_get('https://api.openode.io/instances/152/events',
                            'test/fixtures/http/openode_api/admin/get_act_stream.json',
                            logged_in_user_token),
      HttpStubs.default_get('https://api.openode.io/instances/152/events/150',
                            'test/fixtures/http/openode_api/admin/get_event.json',
                            logged_in_user_token),
      HttpStubs.default_post('https://api.openode.io/account/regenerate-token',
                             {},
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_post('https://api.openode.io/instances/152/destroy-storage',
                             {},
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_get('https://api.openode.io/instances/152/storage',
                            'test/fixtures/http/openode_api/admin/get_storage.json',
                            logged_in_user_token),
      HttpStubs.default_post('https://api.openode.io/instances/152/increase-storage',
                             { "amount_gb" => "1" },
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_post('https://api.openode.io/instances/152/add-storage-area',
                             { "storage_area" => "/home" },
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_post('https://api.openode.io/instances/152/del-storage-area',
                             { "storage_area" => "/home/what" },
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_patch('https://api.openode.io/account/me',
                              {
                                "account" => {
                                  "nb_credits_threshold_notification" => "50",
                                  "newsletter" => "1"
                                }
                              },
                              'test/fixtures/http/openode_api/empty_object.json',
                              logged_in_user_token),
      HttpStubs.default_delete('https://api.openode.io/account/me',
                               'test/fixtures/http/openode_api/empty_object.json',
                               logged_in_user_token),
      HttpStubs.default_get('https://api.openode.io/instances/',
                            'test/fixtures/http/openode_api/admin/get_instances.json',
                            logged_in_user_token),
      HttpStubs.default_post('https://api.openode.io/super_admin/support/contact',
                             {
                               "email" => "toto@gmail.com",
                               "message" => "hello",
                               "site_name" => "sitename"
                             },
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_patch('https://api.openode.io/instances/152/collaborators/7',
                              {
                                "collaborator" => {
                                  "email" => "titi@gmail.com",
                                  "permissions" => ["root"]
                                }
                              },
                              'test/fixtures/http/openode_api/empty_object.json',
                              logged_in_user_token),
      HttpStubs.default_post('https://api.openode.io/instances/152/add-alias',
                             {
                               "hostname" => "asdf.test.com"
                             },
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_post('https://api.openode.io/instances/152/del-alias',
                             {
                               "hostname" => "www.iochain.co"
                             },
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_delete('https://api.openode.io/instances/152',
                               'test/fixtures/http/openode_api/empty_object.json',
                               logged_in_user_token),
      HttpStubs.default_post('https://api.openode.io/instances/152/restart',
                             {},
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_post('https://api.openode.io/notifications/view',
                             { "notifications" => ["155"] },
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_post('https://api.openode.io/instances/152/stop',
                             {},
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_patch('https://api.openode.io/account/me',
                              {
                                "account" => {
                                  "email" => "asdf@gmail.com",
                                  "account" => {
                                    "name" => "asdf"
                                  }
                                }
                              },
                              'test/fixtures/http/openode_api/empty_object.json',
                              logged_in_user_token),
      HttpStubs.default_get(
        'https://api.openode.io/account/spendings',
        'test/fixtures/http/openode_api/admin/get_account_spendings.json',
        logged_in_user_token
      ),
      HttpStubs.default_post('https://api.openode.io/instances/152/set-plan',
                             {
                               "plan" => '50-MB'
                             },
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_post('https://api.openode.io/instances/152/set-plan',
                             {
                               "plan" => 'open_source'
                             },
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_patch('https://api.openode.io/instances/152',
                              {
                                "website" => {
                                  "open_source" => {
                                    "title" => "hello",
                                    "description" => "desc",
                                    "repository_url" => "http://google.com/"
                                  }
                                }
                              },
                              'test/fixtures/http/openode_api/empty_object.json',
                              logged_in_user_token),
      HttpStubs.default_post('https://api.openode.io/super_admin/websites/152/update_open_source_request',
                             {
                               "open_source_request" => {
                                 "reason" => "reason x",
                                 "status" => "approved"
                               }
                             },
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_post('https://api.openode.io/instances/152/cmd',
                             {
                               "cmd" => "df -h", "app" => "www"
                             },
                             'test/fixtures/http/openode_api/admin/post_cmd.json',
                             logged_in_user_token),
      HttpStubs.default_post('https://api.openode.io/account/activate/userid/activationhash',
                             {
                             },
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_get(
        'https://api.openode.io/super_admin/websites/152',
        'test/fixtures/http/openode_api/super_admin/get_website.json',
        logged_in_user_token
      ),
      HttpStubs.default_get(
        'https://api.openode.io/instances/152/dns',
        'test/fixtures/http/openode_api/admin/get_dns.json',
        logged_in_user_token
      ),
      HttpStubs.default_get(
        'https://api.openode.io/super_admin/orders/?search=',
        'test/fixtures/http/openode_api/super_admin/get_orders.json',
        logged_in_user_token
      ),
      HttpStubs.default_patch('https://api.openode.io/account/me',
                              {
                                "account" => {
                                  "password" => "Passwddd112",
                                  "password_confirmation" => "Passwddd112"
                                }
                              },
                              'test/fixtures/http/openode_api/empty_object.json',
                              logged_in_user_token),
      HttpStubs.default_get(
        'https://api.openode.io/super_admin/stats/spendings',
        'test/fixtures/http/openode_api/super_admin/get_spendings.json',
        logged_in_user_token
      ),
      HttpStubs.default_get(
        'https://api.openode.io/super_admin/stats/nb_online',
        'test/fixtures/http/openode_api/super_admin/get_nb_online.json',
        logged_in_user_token
      ),
      HttpStubs.default_get(
        'https://api.openode.io/super_admin/stats/system?variable_name=nb_active_users',
        'test/fixtures/http/openode_api/super_admin/get_nb_online.json',
        logged_in_user_token
      ),
      HttpStubs.default_get(
        'https://api.openode.io/instances/152/executions/1234',
        'test/fixtures/http/openode_api/admin/get_deployment.json',
        logged_in_user_token
      ),
      HttpStubs.default_post('https://api.openode.io/instances/152/set-config',
                             {
                               "value" => "cert/crt.crt",
                               "variable" => "SSL_CERTIFICATE_PATH"
                             },
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_post('https://api.openode.io/instances/152/set-config',
                             {
                               "value" => "cert/key.key",
                               "variable" => "SSL_CERTIFICATE_KEY_PATH"
                             },
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_get(
        'https://api.openode.io/instances/152/status',
        'test/fixtures/http/openode_api/empty_object.json',
        logged_in_user_token
      ),
      HttpStubs.default_get(
        'https://api.openode.io/instances/152/stats/network',
        'test/fixtures/http/openode_api/admin/stats_network.json',
        logged_in_user_token
      ),
      HttpStubs.default_get(
        'https://api.openode.io/instances/152/executions/list/Deployment/' \
        '?status=success',
        'test/fixtures/http/openode_api/admin/latest_deployment_success.json',
        logged_in_user_token
      ),
      HttpStubs.default_post('https://api.openode.io/instances/152/restart?parent_execution_id=1234564',
                             {
                             },
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_get(
        'https://api.openode.io/instances/152/logs?nbLines=100',
        'test/fixtures/http/openode_api/admin/access_logs.json',
        logged_in_user_token
      ),
      HttpStubs.default_get(
        'https://api.openode.io/instances/152/env_variables',
        'test/fixtures/http/openode_api/admin/env_variables.json',
        logged_in_user_token
      ),
      HttpStubs.default_put('https://api.openode.io/instances/152/env_variables',
                            { 'variables' => { 'var1' => 'val1' } },
                            'test/fixtures/http/openode_api/empty_object.json',
                            logged_in_user_token),
      HttpStubs.default_get(
        'https://api.openode.io/global/type-lists/Website::ALERT_TYPES',
        'test/fixtures/http/openode_api/front/global_type_lists_alerts.json',
        logged_in_user_token
      ),
      HttpStubs.default_patch('https://api.openode.io/instances/152/',
                              { "website" => { "alerts" => ["stop_lacking_credits"] } },
                              'test/fixtures/http/openode_api/empty_object.json',
                              logged_in_user_token),
      HttpStubs.default_post('https://api.openode.io/instances/152/snapshots',
                             { "path" => "/var/www/" },
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_get(
        'https://api.openode.io/instances/152/snapshots',
        'test/fixtures/http/openode_api/admin/get_snapshots.json',
        logged_in_user_token
      ),
      HttpStubs.default_get(
        'https://api.openode.io/instances/152/snapshots/1234',
        'test/fixtures/http/openode_api/admin/get_snapshot.json',
        logged_in_user_token
      ),
      HttpStubs.default_get(
        'https://api.openode.io/instances/152/summary',
        'test/fixtures/http/openode_api/admin/get_instance_summary.json',
        logged_in_user_token
      ),
      HttpStubs.default_get(
        'https://api.openode.io/super_admin/stats/generic_daily_stats?attrib_to_sum=1&entity=Deployment&entity_method=type_dep',
        'test/fixtures/http/openode_api/super_admin/get_deployments.json',
        logged_in_user_token
      ),
      HttpStubs.default_get(
        'https://api.github.com/repos/openode-io/build-templates/git/trees/master?recursive=true',
        'test/fixtures/http/front/build_templates.txt',
        logged_in_user_token
      ),
      HttpStubs.default_get(
        'https://api.openode.io/instances/152/addons',
        'test/fixtures/http/openode_api/admin/addons.json',
        logged_in_user_token
      ),
      HttpStubs.default_get(
        'https://api.openode.io/global/addons',
        'test/fixtures/http/openode_api/available_addons.json',
        logged_in_user_token
      ),
      HttpStubs.default_post('https://api.openode.io/instances/152/addons/',
                             { "addon" => { "addon_id" => "1234" } },
                             'test/fixtures/http/openode_api/empty_object.json',
                             logged_in_user_token),
      HttpStubs.default_get(
        'https://api.openode.io/instances/152/addons/7',
        'test/fixtures/http/openode_api/admin/addon.json',
        logged_in_user_token
      ),
      HttpStubs.default_patch('https://api.openode.io/instances/152/addons/7',
                              {
                                "addon" => {
                                  "name" => "titi"
                                }
                              },
                              'test/fixtures/http/openode_api/empty_object.json',
                              logged_in_user_token),
      HttpStubs.default_patch('https://api.openode.io/instances/152/addons/7',
                              {
                                "addon" => {
                                  "name" => "titi\\n"
                                }
                              },
                              'test/fixtures/http/openode_api/empty_object.json',
                              logged_in_user_token)
    ]
  end
end
