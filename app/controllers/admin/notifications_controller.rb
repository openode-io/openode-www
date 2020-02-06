class Admin::NotificationsController < AdminController
  skip_before_action :verify_authenticity_token

  def index
    # -
  end

  def mark_read
    render json: { status: 'OK' }
  end
end