class Admin::AccountController < AdminController
  before_action do
    add_breadcrumb "Account",
                   admin_account_path
  end

  def index
    add_breadcrumb "Profile"

    # If nothing to show on index, then redirect to profile as default page
    redirect_to admin_account_profile_path
  end

  def account_api
  end

  def notifications_and_newsletter
    add_breadcrumb "Notifications & Newsletter"

    @account = api(:get, "/account/me")
  end

  def update_notifications_and_newsletter
    api(:patch, "/account/me", payload: { account: user_params })

    redirect_to({ action: :notifications_and_newsletter },
                notice: msg('message.modifications_saved'))
  end

  def api_access
    add_breadcrumb "API & CLI"

    @token = session[:token]
  end

  def regenerate_token
    result = api(:post, "/account/regenerate-token")

    token = result['token']
    user = api(:get, "/account/me", token: token)
    set_session(token, user)

    redirect_to action: :api_access
  end

  def profile
    add_breadcrumb "Profile"
  end

  protected

  def user_params
    params.require(:user).permit(:nb_credits_threshold_notification, :newsletter)
  end
end
