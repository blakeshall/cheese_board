class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def cheddar
    puts request.env["omniauth.auth"]
    @user = User.find_for_cheddar_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Cheddar") if is_navigational_format?
    else
      redirect_to root_path
    end
  end
end