require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get '/'

    assert_response :success
    assert_includes response.parsed_body, "| opeNode</title>"
  end

  test "should get pricing" do
    get '/pricing'

    assert_response :success
    assert_includes response.parsed_body, "Home#pricing"
  end

  test "should get private_cloud_pricing" do
    get '/pricing-private-cloud'

    assert_response :success
    assert_includes response.parsed_body, "Home#private_cloud_pricing"
  end

  test "should get about" do
    get '/about'

    assert_response :success
    assert_includes response.parsed_body, "Home#about"
  end

  test "should get news" do
    get '/news'

    assert_response :success
    assert_includes response.parsed_body, "Home#news"
  end

  test "should get locations" do
    get '/locations'

    assert_response :success
    assert_includes response.parsed_body, "Home#locations"
  end

  test "should get openode cli" do
    get '/openode-cli'

    assert_response :success
    assert_includes response.parsed_body, "Home#openode_cli"
  end

  test "should get faq" do
    get '/faq'

    assert_response :success
    assert_includes response.parsed_body, "Home#faq"
  end

  test "should get support" do
    get '/support'

    assert_response :success
    assert_includes response.parsed_body, "Home#support"
  end

  test "should get terms" do
    get '/terms'

    assert_response :success
    assert_includes response.parsed_body, "Home#terms"
  end

  test "should get privacy" do
    get '/privacy'

    assert_response :success
    assert_includes response.parsed_body, "Home#privacy"
  end
end
