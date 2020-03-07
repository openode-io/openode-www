
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

  def self.default_patch(url, body, response_file, logged_in_user_token)
    {
      url: url,
      method: :patch,
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

  def self.default_post(url, body, response_file, logged_in_user_token)
    {
      url: url,
      method: :post,
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
                             logged_in_user_token)
    ]
  end
end
