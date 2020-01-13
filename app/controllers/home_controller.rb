class HomeController < ApplicationController
  include Recaptchable

  before_action only: [:index, :about] do
    @global_stats = Rails.cache.fetch('/api/global/stats', expires_in: 12.hours) do
      api(:get, '/global/stats') rescue {}
    end
  end

  def index
    # -
  end

  def pricing
    @pricing_plans =
      YAML.load_file(Rails.root.join("config/pricing.yml")).map(&:deep_symbolize_keys)
  end

  def private_cloud_pricing
    # -
  end

  def about
    # -
  end

  def news
    # -
  end

  def locations
    @locations = YAML.load_file(Rails.root.join("config/locations.yml"))
                     .map(&:deep_symbolize_keys)
  end

  def openode_cli
    # -
  end

  def faq
    # -
  end

  def support
    # -
  end

  def terms
    # -
  end

  def privacy
    # -
  end

  def opensource
    @opensource_projects = YAML.load_file(Rails.root.join("config/opensource.yml"))
                               .map(&:deep_symbolize_keys) rescue []
    @featured_projects = @opensource_projects.select { |o| o[:featured] } rescue []
  end

  def opensource_item
    @opensource_project = YAML.load_file(Rails.root.join("config/opensource.yml"))
                              .map(&:deep_symbolize_keys)
                              .select { |o| o[:slug] == params[:slug] }.first rescue {}
  end
end
