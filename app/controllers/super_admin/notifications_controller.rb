class SuperAdmin::NotificationsController < SuperAdminController
  def index
    search_for = params.dig(:notifications_search, :search)
    @notifications = api(:get, "/notifications/all?search=#{search_for}")
  end

  def new
    @levels = make_lister_selection(%w[info warning critical priority])
    @types = make_lister_selection(%w[GlobalNotification WebsiteNotification])
  end

  def create
    api(:post, "/notifications/", payload: { notification: notification_params })

    redirect_to({ action: :index }, notice: "Created!")
  end

  def destroy
    api(:delete, "/notifications/#{params['id']}")

    redirect_to({ action: :index }, notice: "Removed!")
  end

  protected

  def notification_params
    params.require(:notification).permit(:type, :level, :content, :website_id)
  end
end
