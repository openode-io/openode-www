require 'redcarpet'
require 'rouge'

class DocsController < ApplicationController
  before_action :set_docs_menu_variables

  def view
    @doc_renderer ||= Redcarpet::Render::HTML.new(no_links: true, hard_wrap: true)
    renderer = CustomRedcarpetRendererService
    @markdown ||= Redcarpet::Markdown.new(renderer, fenced_code_blocks: true)

    file_path = Rails.root.join("public/documentation/#{@section}/#{@document}.md")

    return redirect_to root_url, flash: { error: "Invalid" } unless File.file?(file_path)

    @result = @markdown.render(File.read(file_path))
    Rouge::Themes::Base16.mode(:light).render(scope: '.highlight')
  end

  private

  def set_docs_menu_variables
    @section = params[:section]
    @document = params[:document] || 'index'
    @docs_file_path = Rails.root.join("public/documentation/index.json").to_s
    @docs_menu = JSON.parse(File.open(@docs_file_path).read)
    @docs_menu = @docs_menu.map(&:deep_symbolize_keys)
  end
end
