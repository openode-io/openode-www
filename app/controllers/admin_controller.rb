class AdminController < ApplicationController
  before_action :authenticate_user
  before_action :set_menu
  before_action :set_notifications
  before_action :set_latest_notification

  layout 'admin'

  def index
    # -
  end

  private

  def set_latest_notification
    @notification = {
      status: 'unread',
      level: 'warning',
      body: 'Maintenance scheduled for Montreal location.'
    }
  end

  def set_notifications
    @notifications = [
      {
        status: 'read',
        level: 'warning',
        icon: 'hammer',
        body: 'Maintenance scheduled for Montreal location.'
      },
      {
        status: 'unread',
        level: 'critical',
        icon: 'exclamation-triangle',
        body: 'Instance down!'
      }
    ]
  end

  def set_menu
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
