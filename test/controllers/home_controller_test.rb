require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get '/'

    assert_response :success
    assert_includes response.parsed_body, "| Home</title>"
  end

  test "should get pricing" do
    get '/pricing'

    assert_response :success
    assert_includes response.parsed_body, "| Pricing</title>"
  end

  test "should get private_cloud_pricing" do
    get '/pricing-private-cloud'

    assert_response :success
    assert_includes response.parsed_body, "| Pricing</title>"
  end

  test "should get about" do
    get '/about'

    assert_response :success
    assert_includes response.parsed_body, "| About Us</title>"
  end

  test "should get news" do
    get '/news'

    assert_response :success
    assert_includes response.parsed_body, "| News</title>"
  end

  test "should get locations" do
    get '/locations'

    assert_response :success
    assert_includes response.parsed_body, "| Locations</title>"
  end

  test "should get openode cli" do
    get '/openode-cli'

    assert_response :success
    assert_includes response.parsed_body, "| CLI</title>"
  end

  test "should get faq" do
    get '/faq'

    assert_response :success
    assert_includes response.parsed_body, "| FAQ</title>"
  end

  test "should get support" do
    get '/support'

    assert_response :success
    assert_includes response.parsed_body, "| Support</title>"
  end

  test "should get terms" do
    get '/terms'

    assert_response :success
    assert_includes response.parsed_body, "| Terms</title>"
  end

  test "should get privacy" do
    get '/privacy'

    assert_response :success
    assert_includes response.parsed_body, "| Privacy</title>"
  end
end
