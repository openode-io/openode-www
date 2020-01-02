class HomeController < ApplicationController
  before_action only: [:index, :about] do
    @global_stats = Rails.cache.fetch('/api/global/stats', expires_in: 12.hours) do
      api(:get, '/global/stats')
    end
  end

  def index
    # -
  end

  def pricing
    # -
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
    # -
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
    # -
  end
end
