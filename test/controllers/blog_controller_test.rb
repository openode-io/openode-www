require 'test_helper'

class BlogControllerTest < ActionDispatch::IntegrationTest
  test "should get blog home" do
    get '/blog'

    assert_response :success
    assert_includes response.parsed_body, "Blog#index"
  end

  test "should get blog post" do
    get '/blog/post/asdf'

    assert_response :success
    assert_includes response.parsed_body, "Blog#post"
  end
end
