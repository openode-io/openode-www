class UsersController < ApplicationController
  def register; end

  def create
    response = api(:post, '/account/register', payload: user_params)

    json(response)
  end

  def forgot_password; end

  def process_forgot_password; end

  def activate; end

  private

  def user_params
    params.require(:account).permit(:email, :password,
                                    :password_confirmation, :newsletter)
  end
end
