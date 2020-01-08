module DocsHelper
  def doc_title(section, document)
    if document.downcase != 'index'

      doc_path = "#{section}/#{document}.md"

      document_records = doc_section_item(section).select do |o|
        o['path'] == doc_path
      end

      "#{document_records.first['name']} | #{section.titleize} | Documentation | opeNode"
    else
      "#{section.titleize} | Documentation | opeNode"
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

  def item_underscore(item)
    item[:name].titleize.gsub(' ', '').underscore
  end

  def collapsed_item_class(section, item)
    section.titleize.downcase == item[:name].downcase ? 'show' : ''
  end

  def active_item_class(section, item, document = '', subitem = '')
    if document.present? && subitem.present?
      subitem_path_match = subitem[:path] == "#{section.downcase}/#{document.downcase}.md"
      section_item_match = section.titleize.downcase == item[:name].downcase
      result = subitem_path_match && section_item_match ? 'text-success' : ''
    else
      section_item_match = section.titleize.downcase == item[:name].downcase
      result = section_item_match ? 'text-success' : 'text-white'
    end

    result
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
end
