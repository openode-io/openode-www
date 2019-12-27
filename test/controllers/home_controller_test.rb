require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get '/'

    assert_response :success
    assert_includes response.parsed_body, "<title>Home"
  end

  test "should get pricing" do
    get '/pricing'

    assert_response :success
    assert_includes response.parsed_body, "<title>Pricing"
  end

  test "should get private_cloud_pricing" do
    get '/pricing-private-cloud'

    assert_response :success
    assert_includes response.parsed_body, "<title>Pricing"
  end

  test "should get about" do
    get '/about'

    assert_response :success
    assert_includes response.parsed_body, "<title>About Us"
  end

  test "should get news" do
    get '/news'

    assert_response :success
    assert_includes response.parsed_body, "<title>News"
  end

  test "should get locations" do
    get '/locations'

    assert_response :success
    assert_includes response.parsed_body, "<title>Locations"
  end

  test "should get faq" do
    get '/faq'

    assert_response :success
    assert_includes response.parsed_body, "<title>FAQ"
  end

  test "should get support" do
    get '/support'

    assert_response :success
    assert_includes response.parsed_body, "<title>Support"
  end

  test "should get terms" do
    get '/terms'

    assert_response :success
    assert_includes response.parsed_body, "<title>Terms"
  end

  test "should get privacy" do
    get '/privacy'

    assert_response :success
    assert_includes response.parsed_body, "<title>Privacy"
  end

  test "should get openode-cli" do
    get '/openode-cli'

    assert_response :success
    assert_includes response.parsed_body, "<title>CLI"
  end
end
