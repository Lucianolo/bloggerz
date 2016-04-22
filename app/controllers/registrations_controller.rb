class RegistrationsController < Devise::RegistrationsController


  def create
    super
    UserNotifier.welcome_email(@user).deliver_now unless @user.invalid?
  end
  

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :profile_name, :email, :password, :password_confirmation, :avatar, :avatar_cache )
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :avatar, :avatar_cache )
  end
end