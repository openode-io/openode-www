class AdminController < ApplicationController
  before_action :authenticate_user
  before_action :set_menu
  before_action :set_latest_notification

  layout 'admin'

  protected

  def make_lister_selection(list)
    list.map { |element| [element, element] }
  end

  private

  def set_latest_notification
    @notification = nil
    notifications = api(:get, '/notifications/?limit=1&types=GlobalNotification')

    if notifications['notifications'].present?
      @notification = notifications['notifications'].first
    end
  end

  def set_menu
    # to set a tips per action:
    # @tips = "This is the instances page, where you can see your instances."

    @section = 'admin'
    @menu = [
      {
        header: true,
        title: 'Main Navigation',
        hiddenOnCollapse: true
      },
      {
        href: '/',
        title: 'Dashboard',
        icon: 'fa fa-user'
      },
      {
        href: '/charts',
        title: 'Charts',
        icon: 'fa fa-chart-area',
        child: [
          {
            href: '/charts/sublink',
            title: 'Sub Link'
          }
        ]
      }
    ]
  end
end
