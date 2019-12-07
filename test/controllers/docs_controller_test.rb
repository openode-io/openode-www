require 'test_helper'

class DocsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get '/docs'
    assert_response :success
    assert_includes response.parsed_body, "Docs#index"
  end

  test "should get view" do
    get '/doc/helloworld'
    assert_response :success
    assert_includes response.parsed_body, "Docs#view"
  end
end
