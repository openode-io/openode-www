class Admin::NotificationsController < AdminController
  skip_before_action :verify_authenticity_token

  def index
    # -
    notifications = api(:get, '/notifications/?limit=5')

    render json: notifications
  end

  def mark_read
    render json: { status: 'OK' }
  end
end
