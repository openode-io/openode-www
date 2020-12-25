require 'redcarpet'
require 'rouge'

class DocsController < ApplicationController
  before_action :set_docs_menu_variables, only: [:view]
  before_action :set_main_menu_variables

  def view
    file_path = Rails.root.join("public/documentation/#{@section}/#{@document}.md")

    return redirect_to root_url, flash: { error: "Invalid" } unless File.file?(file_path)

    @result = @markdown.render(File.read(file_path))
    Rouge::Themes::Base16.mode(:light).render(scope: '.highlight')
    @root_section = "docs"
  end

  def addons
    addon_base_repo_url = "https://raw.githubusercontent.com/openode-io/addons/master"
    addons = api(:get, '/global/addons')
    category_names = addons.map { |addon| addon["category"] }.uniq
    addon = addons.find { |a| a["name"] == @document }

    @docs_menu = category_names.map do |category_name|
      {
        name: category_name,
        path: "#{category_name}/index.md",
        children:
          addons.select { |a| a["category"] == category_name }
                .map do |a|
                  { name: (a['name']).to_s,
                    path: "#{category_name}/#{a['name']}.md" }
                end
      }
    end

    readme_document = if addon.present?
                        "#{addon['name']}/#{addon['obj']['documentation_filename']}"
                      else
                        "README.md"
                      end

    url_readme = "#{addon_base_repo_url}/#{@section}/#{readme_document}"
    markdown_content = RestClient::Request.execute(method: :get, url: url_readme)

    @image_addon = if addon
                     url_config = "#{addon_base_repo_url}/#{@section}/#{addon['name']}/" \
                                  "config.json"
                     addon_config = RestClient::Request.execute(method: :get,
                                                                url: url_config)
                     markdown_content += "\n\n## Default configs:\n" \
                       "See [the repository](https://github.com/openode-io/addons) " \
                       "for the configurations definition.\n\n"

                     addon_config.lines.each do |line_config|
                       markdown_content += "    #{line_config}\n"
                     end

                     "#{addon_base_repo_url}/#{@section}/#{addon['name']}/" \
                     "#{addon['obj']['logo_filename']}"
    end

    @result = @markdown.render(markdown_content)
    Rouge::Themes::Base16.mode(:light).render(scope: '.highlight')
    @root_section = "addons"
  end

  private

  def set_main_menu_variables
    @section = params[:section]
    @document = params[:document] || 'index'

    renderer = CustomRedcarpetRendererService
    @markdown ||= Redcarpet::Markdown.new(renderer, fenced_code_blocks: true)
  end

  def set_docs_menu_variables
    docs_file_path = Rails.root.join("public/documentation/index.json").to_s
    @docs_menu = JSON.parse(File.open(docs_file_path).read)
    @docs_menu = @docs_menu.map(&:deep_symbolize_keys)
  end
end
