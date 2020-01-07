# frozen_string_literal: true

module ApplicationHelper
  def title
    if content_for?(:title)
      content_for :title
    else
      t("#{controller_path.tr('/', '.')}.#{action_name}.title", default: :site_name)
    end
  end

  def doc_title(section, document)
    if document.downcase != 'index'

      doc_path = "#{section}/#{document}.md"

      document_records = doc_section_item(section).select do |o|
        o['path'] == doc_path
      end

      "Docs | #{section.titleize} | #{document_records.first['name']} | opeNode"
    else
      "Docs | #{section.titleize} | opeNode"
    end
  end

  def doc_section_item(section)
    docs_path = Rails.root.join("public/documentation/index.json").to_s
    docs_menu = JSON.parse(File.open(docs_path).read)

    section_items = docs_menu.select do |o|
      o['name'].downcase == section.titleize.downcase
    end

    section_items.first['children']
  end

  def directory_hash(path, name = nil, exclude = [])
    exclude.concat(['..', '.', '.git', '__MACOSX', '.DS_Store'])

    data = { text: (name || path) }
    data[:children] = children = []

    Dir.foreach(path) do |entry|
      next if exclude.include?(entry) || entry.downcase.include?('.json')

      full_path = File.join(path, entry)
      children << if File.directory?(full_path)
                    directory_hash(full_path, entry)
                  else
                    { icon: '', text: entry.gsub(/.md|.mdx/, '') }
                  end
    end

    data.as_json.deep_symbolize_keys
  end

  def flash_bootstrap(level)
    level = 'notice' if level.blank?

    case level
    when 'warning' then "alert alert-warning"
    when /success|ok|notice/ then "alert alert-success auto-close"
    when /error|alert/ then "alert alert-danger"
    end
  end
end
