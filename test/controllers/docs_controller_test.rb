require 'test_helper'

class DocsControllerTest < ActionDispatch::IntegrationTest
  test "get introduction index" do
    get '/docs/introduction/index'

    assert_response :success
    assert_includes response.parsed_body.to_s, '<h1>Introduction</h1>'
  end

  test "get introduction without index" do
    get '/docs/introduction/'

    assert_response :success
    assert_includes response.parsed_body.to_s, '<h1>Introduction</h1>'
  end

  test "cli" do
    get '/docs/platform/cli'

    assert_response :success
    assert_includes response.parsed_body.to_s, '<h1>openode-cli</h1>'
  end
end
