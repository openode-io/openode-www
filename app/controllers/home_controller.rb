require 'rest-client'

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
    @pricing_plans ||=
      YAML.load_file(Rails.root.join("config/pricing_v3.yml")).map(&:deep_symbolize_keys)
  end

  def on_demand_pricing
    redirect_to action: :pricing
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

  def send_support
    api(:post, '/super_admin/support/contact',
        payload: support_params, token: ENV['SUPER_ADMIN_API_TOKEN'])

    redirect_back fallback_location: { action: "support" },
                  notice: "Support request sent successfully!"
  end

  def terms
    # -
  end

  def privacy
    # -
  end

  def opensource
    @opensource_projects = api(:get, '/open_source_projects/latest') rescue []

    @featured_projects = []
  end

  def kb
  end

  def templates
    url = "https://api.github.com/repos/openode-io/build-templates/git/trees/master" \
            "?recursive=true"
    @templates = JSON.parse(RestClient::Request.execute(method: :get,
                                                        url: url))['tree']
                     .select do |item|
                   item['path'].include?('v1/templates/') &&
                     item['path'].include?('/Dockerfile')
                 end
                     .map do |item|
      orig_path = item['path']

      path = orig_path.gsub('/Dockerfile', '')
      name = orig_path.gsub('/Dockerfile', '').gsub('v1/templates/', '')

      url_template =
        "https://github.com/openode-io/build-templates/tree/master/#{path}"

      {
        path: path,
        name: name,
        url_template: url_template
      }
    end
  end

  def opensource_item
    site_name = params["slug"]

    @opensource_project = api(:get, "/open_source_project/#{site_name}") rescue {}
  end

  private

  def support_params
    params.require(:support).permit(:email, :message, :site_name)
  end
end
