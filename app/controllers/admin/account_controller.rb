class Admin::AccountController < AdminController
  def index
    add_breadcrumb "Account",
                   admin_account_path
    add_breadcrumb "Profile"

    # If nothing to show on index, then redirect to profile as default page
    redirect_to admin_account_profile_path
  end

  def account_api
  end

  def notifications_and_newsletter
    add_breadcrumb "Account",
                   admin_account_path
    add_breadcrumb "Notifications & Newsletter"
  end

  def update_notifications_and_newsletter
  end

  def api_access
    add_breadcrumb "Account",
                   admin_account_path
    add_breadcrumb "API & CLI"
  end

  def regenerate_token
  end

  def profile
    add_breadcrumb "Account",
                   admin_account_path
    add_breadcrumb "Profile"
  end
end
