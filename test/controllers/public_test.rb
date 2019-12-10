class PublicAssetsTest < ActionDispatch::IntegrationTest
  test "access index json documentation" do
    get '/documentation/index.json'

    assert_response :success
    assert_includes response.parsed_body[0]['name'], "Introduction"
  end

  test "access all documents" do
    get '/documentation/index.json'

    assert_response :success
    assert_includes response.parsed_body[0]['name'], "Introduction"

    response.parsed_body.each do |document|
      if document['path']
        cur_path = "/documentation/#{document['path']}"
        Rails.logger.info "Test public document #{cur_path}"

        get cur_path

        assert_response :success
      end

      next unless document['children']

      document['children'].each do |child|
        next unless child['path']

        cur_child_path = "/documentation/#{child['path']}"
        Rails.logger.info "Test public document #{cur_child_path}"

        get cur_child_path

        assert_response :success
      end
    end
  end
end
