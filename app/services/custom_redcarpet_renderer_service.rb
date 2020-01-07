require 'redcarpet'
require 'redcarpet/compat'
require 'rouge'
require 'rouge/plugins/redcarpet'

class CustomRedcarpetRendererService < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end
