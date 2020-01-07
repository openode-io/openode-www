require 'redcarpet'
require 'rouge'

class DocsController < ApplicationController
  def view
    @doc_renderer ||= Redcarpet::Render::HTML.new(no_links: true, hard_wrap: true)
    renderer = CustomRedcarpetRendererService
    @markdown ||= Redcarpet::Markdown.new(renderer, fenced_code_blocks: true)

    @section = params[:section]
    @document = params[:document] || 'index'
    file_path = Rails.root.join("public/documentation/#{@section}/#{@document}.md")

    unless File.file?(file_path)
      return redirect_to root_url, flash: { error: "Invalid document" }
    end

    @result = @markdown.render(File.read(file_path))
    Rouge::Themes::Base16.mode(:light).render(scope: '.highlight')
  end
end
