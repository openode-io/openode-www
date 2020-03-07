require 'test_helper'

class AdminSupportControllerTest < ActionDispatch::IntegrationTest
  test "support page" do
    perform_successful_login

    get '/admin/support'

    assert_response :success

    assert_includes response.parsed_body, 'For technical support'
    assert_includes response.parsed_body, 'mytestt5667'
  end

  test "send support request" do
    perform_successful_login

    post support_path,
         params: {
           support: {
             email: 'toto@gmail.com',
             site_name: 'sitename',
             message: 'hello'
           }
         }

    assert_response :found
  end
end
