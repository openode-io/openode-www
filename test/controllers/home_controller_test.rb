require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get '/'

    assert_response :success
  end

  test "should get pricing" do
    get '/pricing'

    assert_response :success
  end

  test "should get private_cloud_pricing" do
    get '/pricing-private-cloud'

    assert_response :success
  end

  test "should get about" do
    get '/about'

    assert_response :success
  end

  test "should get news" do
    get '/news'

    assert_response :success
  end
end
