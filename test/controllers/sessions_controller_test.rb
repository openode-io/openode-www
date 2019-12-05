require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "POST /sessions - happy path" do
    post "/sessions",
         params: { email: "mymail@openode.io", password: "1234561!" }

    assert_response :found

    # TODO: add proper redirection check to admin

    assert_equal session["token"], "123456789123"
  end

  test "POST /sessions - with invalid user" do
    post "/sessions",
         params: { email: "invalid@openode.io", password: "123456" }

    assert_response :found
    assert_equal session["token"], nil
  end
end
