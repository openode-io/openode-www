require 'test_helper'

class SuperAdminNewslettersControllerTest < ActionDispatch::IntegrationTest
  test "newsletters" do
    perform_successful_login

    get '/super_admin/newsletters'

    assert_response :success

    assert_includes response.parsed_body.to_s, 'Newsletters'
    assert_includes response.parsed_body.to_s, 'hi world.'
  end

  test "newsletter deliver" do
    perform_successful_login

    post '/super_admin/newsletters/1/deliver'

    assert_response :found
  end

  test "newsletter new" do
    perform_successful_login

    get '/super_admin/newsletters/new'

    assert_response :success

    assert_includes response.parsed_body.to_s, 'custom'
    assert_includes response.parsed_body.to_s, 'newsletter'
  end

  test "newsletter create" do
    perform_successful_login

    post '/super_admin/newsletters/',
         params: {
           newsletter: {
             title: 'custom'
           }
         }

    assert_response :found
  end
end
