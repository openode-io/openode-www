class AdminController < ApplicationController
  before_action :authenticate_user
  before_action :set_menu

  layout 'admin'

  def index
    # -
  end

  def billing
    # -
  end

  def orders
    # -
  end

  def instances
    # -
  end  

  def api
    # -
  end  

  def newsletter
    # -
  end

  def notifications
    # -
  end  

  def profile
    # -
  end

  private

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
