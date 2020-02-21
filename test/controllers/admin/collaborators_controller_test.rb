require 'test_helper'

class AdminCollaboratorsControllerTest < ActionDispatch::IntegrationTest
  test "Collaborators" do
    perform_successful_login

    get '/admin/instances/152/collaborators'

    assert_response :success

    assert_includes response.parsed_body, 'Collaborators'
    assert_includes response.parsed_body, 'asdf234asdfasdffds@gmaill.com'
  end
end
