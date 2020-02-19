class SuperAdminController < AdminController
  before_action :ensure_super_admin

  def index
    # -
  end

  private

  def ensure_super_admin
    unless super_admin?
      redirect_to '/', notice: "Not authorized!"
    end
  end

  def set_latest_notification
    @notification = nil
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
