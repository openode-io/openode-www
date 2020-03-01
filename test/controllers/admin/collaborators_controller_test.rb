require 'test_helper'

class AdminCollaboratorsControllerTest < ActionDispatch::IntegrationTest
  test "Collaborators" do
    perform_successful_login

    get '/admin/instances/152/collaborators'

    assert_response :found
  end

  test "New Collaborator" do
    perform_successful_login

    get '/admin/instances/152/collaborators/new'

    assert_response :success

    assert_includes response.parsed_body, 'Add a new collaborator'
  end

  test "Create Collaborator" do
    perform_successful_login

    post '/admin/instances/152/collaborators',
         params: {
           collaborator: {
             email: 'titi@toto.com',
             permissions: ['dns']
           }
         }

    assert_response :found
  end
end
