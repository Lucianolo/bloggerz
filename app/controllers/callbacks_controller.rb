class CallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token
    
    
      
    def facebook
        @user = User.from_omniauth(request.env["omniauth.auth"])
        
        #o = [('a'..'z'), ('A'..'Z'), (1..9)].map { |i| i.to_a }.flatten
        #string = (0...50).map { o[rand(o.length)] }.join
        
        #@user.update(password: string)

        if @user.sign_in_count == 0
            UserNotifier.welcome_email(@user).deliver_now #unless @user.invalid?
        end
        
        #@user.skip_confirmation! 
        @user.add_role "user"
        
        sign_in_and_redirect @user
    end
    
    
  
    def after_sign_in_path_for(resource_or_scope)
        geocoding_path
    end
  
end