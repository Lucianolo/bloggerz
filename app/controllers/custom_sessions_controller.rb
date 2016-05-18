class CustomSessionsController < Devise::SessionsController

    def create
        
        super
        
        user_lat = params[:user][:user_lat]
        user_lng = params[:user][:user_lng]
        

        @user.update(user_lat: user_lat, user_lng: user_lng)
    end 
    
   
end