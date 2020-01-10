# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'webmock/minitest'

class ActiveSupport::TestCase
  http_stubs = [
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
    }
  ]

  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  setup do
    http_stubs.each do |http_stub|
      stub_request(http_stub[:method], http_stub[:url])
        .with(body: http_stub[:with][:body])
        .to_return(status: http_stub[:response_status],
                   body: IO.read(http_stub[:response_path]),
                   headers: { content_type: http_stub[:content_type] })
    end
  end

  def perform_successful_login
    post "/sessions",
         params: { email: "mymail@openode.io", password: "1234561!" }
  end
  # Add more helper methods to be used by all tests here...
end
