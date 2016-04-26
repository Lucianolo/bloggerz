class CallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token
    
    
      
    def facebook
        @user = User.from_omniauth(request.env["omniauth.auth"])
        UserNotifier.welcome_email(@user).deliver_now unless @user.invalid?
        sign_in_and_redirect @user
    end
  
end