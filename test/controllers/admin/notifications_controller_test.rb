require 'test_helper'

class AdminNotificationsControllerTest < ActionDispatch::IntegrationTest
  test "get latest notifications" do
    perform_successful_login

    get '/admin/notifications'

    assert_response :success

    # dropdown notifications
    assert_equal response.parsed_body['nb_unviewed'], 8
    assert_equal response.parsed_body['notifications'].length, 5
    assert_includes response.parsed_body['notifications'][2]['content'],
                    'hello world whelasdf web3'
    assert_includes response.parsed_body['notifications'][3]['content'],
                    'hello world whelasdf web2'
    assert_includes response.parsed_body['notifications'][4]['content'],
                    'hello world whelasdf web1'
  end
end
