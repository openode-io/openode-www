class Admin::NotificationsController < AdminController
  def index
    # -

    # will call api to mark all viewed
  end

  # params: { notifications: [notification ids] }
  def mark_viewed
    # will call the api to mark the notifications

    json({})
  end
end
