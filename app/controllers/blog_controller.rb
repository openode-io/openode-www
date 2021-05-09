
class BlogController < ApplicationController
  def post
    render params['name'].to_s
  end
end
