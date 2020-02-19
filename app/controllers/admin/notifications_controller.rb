class Admin::NotificationsController < AdminController
  skip_before_action only: [:index, :mark_read] do
    verify_authenticity_token
  end

  def index
    notifications = api(:get, '/notifications/?limit=5')

    render json: notifications
  end

  def latest
    @notifications = api(:get, '/notifications/?limit=100').dig("notifications") || []

    api(:post, '/notifications/view?all=true')
  end

  def mark_read
    render json: { status: 'OK' }
  end
end
