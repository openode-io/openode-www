class HomeController < ApplicationController
  include Recaptchable

  before_action only: [:index, :about] do
    @global_stats = Rails.cache.fetch('/api/global/stats', expires_in: 12.hours) do
      api(:get, '/global/stats') rescue {}
    end
  end

  def index
    @recent_projects =
      Rails.cache.fetch("/api/open_source_projects/latest/3", expires_in: 1.hour) do
        (api(:get, '/open_source_projects/latest') rescue []).take(3)
      end
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
    @opensource_projects = api(:get, '/open_source_projects/latest') rescue []

    # @featured_projects = @opensource_projects.select { |o| o[:featured] } rescue []
    @featured_projects = []
  end

  def opensource_item
    site_name = params["slug"]

    @opensource_project = api(:get, "/open_source_project/#{site_name}") rescue {}
  end
end
