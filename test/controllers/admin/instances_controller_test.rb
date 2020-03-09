require 'test_helper'

class AdminInstancesControllerTest < ActionDispatch::IntegrationTest
  test "get summary instances" do
    perform_successful_login

    get '/admin/instances.json'

    assert_response :success

    assert_equal response.parsed_body.length, 2
    assert_equal response.parsed_body[0]['site_name'], 'mytestt5667'
  end

  test "/admin/instances/plans" do
    perform_successful_login

    get '/admin/instances/plans'

    assert_response :success

    assert_equal response.parsed_body[0]['id'], 'sandbox'
  end

  test "/admin/instances/available-locations?type=kubernetes" do
    perform_successful_login

    get '/admin/instances/available-locations?type=kubernetes'

    assert_response :success

    assert_equal response.parsed_body[0]['str_id'], 'canada'
  end

  test "POST /admin/instances/create.json" do
    perform_successful_login

    post '/admin/instances/create.json',
         params: {
           instance: {
             account_type: 'subdomain'
           }
         }

    assert_response :success

    assert_equal response.parsed_body['status']['level'], 'success'
  end

  test "POST /admin/instances/delete.json" do
    perform_successful_login

    post '/admin/instances/152/delete.json',
         params: {}

    assert_response :success

    assert_equal response.parsed_body['status']['level'], 'warning'
  end

  test "POST /admin/instances/deploy.json" do
    perform_successful_login

    post '/admin/instances/152/deploy.json',
         params: {}

    assert_response :success

    assert_equal response.parsed_body['status']['level'], 'warning'
  end
end
