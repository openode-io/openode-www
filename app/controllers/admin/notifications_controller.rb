class Admin::NotificationsController < AdminController
  skip_forgery_protection only: [:index, :mark_read]

  def index
    notifications = api(:get, '/notifications/?limit=5')

    render json: notifications
  end

  def latest
    @notifications = api(:get, '/notifications/?limit=100')["notifications"] || []

    api(:post, '/notifications/view?all=true')
  end

  def mark_read
    api(:post, "/notifications/view",
        payload: { notifications: [params['id']] })

    render json: { status: 'OK' }
  end
end
