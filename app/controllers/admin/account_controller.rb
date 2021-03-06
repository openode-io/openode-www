class Admin::AccountController < AdminController
  before_action do
    add_breadcrumb "Account",
                   admin_account_path
  end

  def index
    # If nothing to show on index, then redirect to profile as default page
    redirect_to(action: :api_access)
  end

  def account_api
  end

  def notifications
    add_breadcrumb "Notifications"

    @account = api(:get, "/account/me")
  end

  def update_notifications_and_newsletter
    api(:patch, "/account/me", payload: { account: user_params })

    redirect_to({ action: :notifications },
                notice: msg('message.modifications_saved'))
  end

  def api_access
    add_breadcrumb "API & CLI"

    @token = session[:token]
    @doc_link = "/docs/platform/cli.md"
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
    @user = OpenStruct.new(api(:get, "/account/me"))
  end

  def update
    api(:patch, "/account/me", payload: {
          account: {
            email: user_params['email'],
            account: user_params['account']
          }
        })

    redirect_to({ action: :profile },
                notice: msg('message.modifications_saved'))
  end

  def destroy
    api(:delete, "/account/me")

    set_session(nil, nil)

    redirect_to('/',
                notice: msg('message.modifications_saved'))
  end

  def change_password
    api(:patch, "/account/me", payload: {
          account: change_password_params
        })

    redirect_to({ action: :profile },
                notice: msg('message.modifications_saved'))
  end

  def invite
    add_breadcrumb "Invite"

    @friend_invites = api(:get, "/account/friend-invites")
  end

  def send_invite
    email = invite_friend_params[:email]
    created_by_ip = request.remote_ip

    api(:post, "/account/invite-friend", payload: {
          email: email,
          created_by_ip: created_by_ip
        })

    redirect_to({ action: :invite },
                notice: msg('message.modifications_saved'))
  end

  protected

  def user_params
    params.require(:user).permit(
      :email,
      :nb_credits_threshold_notification,
      :newsletter,
      account: {}
    )
  end

  def change_password_params
    params.require(:user).permit(
      :password,
      :password_confirmation
    )
  end

  def invite_friend_params
    params.require(:invite).permit(:email)
  end
end
