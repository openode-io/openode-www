# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'webmock/minitest'
require_relative './http_stubs'

class ActiveSupport::TestCase
  logged_in_user_token = '123456789123456'

  http_stubs = HttpStubs.all(logged_in_user_token)

  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  setup do
    http_stubs.each do |http_stub|
      http_stub[:headers] ||= {}

      stub_request(http_stub[:method], http_stub[:url])
        .with(
          body: http_stub[:with][:body]
          # headers: http_stub[:headers]
        )
        .to_return(status: http_stub[:response_status],
                   body: IO.read(http_stub[:response_path]),
                   headers: {
                     content_type: http_stub[:content_type]
                   })
    end
  end

  def perform_successful_login
    post "/sessions",
         params: { email: "mymail@openode.io", password: "1234561!" }
  end

  def perform_successful_super_admin_login
    post "/sessions",
         params: { email: "superadmin@openode.io", password: "1234561!" }
  end
end
