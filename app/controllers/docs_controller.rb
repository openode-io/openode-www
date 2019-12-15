require 'redcarpet'

class DocsController < ApplicationController
  def view
    @doc_renderer ||= Redcarpet::Render::HTML.new(no_links: true, hard_wrap: true)
    @markdown ||= Redcarpet::Markdown.new(@doc_renderer)

    section = params[:section]
    document = params[:document] || 'index'
    file_path = Rails.root.join("public/documentation/#{section}/#{document}.md")
    file_exists = File.file?(file_path)

    return redirect_to root_url, flash: { error: "Invalid document" } unless file_exists

    content = File.read(file_path)

    @result = @markdown.render(content)
  end
end
