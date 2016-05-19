class GeocodingController < ApplicationController
    
    def new
       render 'devise/sessions/create' 
    end
    
    
    def update
        
        user_lat = params[:user][:user_lat]
        user_lng = params[:user][:user_lng]
        User.where(id: current_user.id).last.update(user_lat: user_lat, user_lng: user_lng)
        
        redirect_to root_path
    end
end
