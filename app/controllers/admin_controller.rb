class AdminController < ApplicationController
  before_action :authenticate_user
  before_action :set_menu

  def index
    # -
  end

  def billing
    # -
  end

  def orders
    # -
  end

  private

  def set_menu
    @section = 'admin'
    @menu = [
      {
        "name":"Instances",
        "path":"/admin/instances"
      },
      {
        "name":"Credits",
        "path":"/admin/credits"
      },
      {
        "name":"Account",
        "path":"/admin/account"
      }      
    ]
  end  
end
