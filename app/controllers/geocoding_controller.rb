class GeocodingController < ApplicationController
    before_filter :authenticate_user!
    
    def new
       render 'devise/sessions/create' 
    end
    
    
    def update
        user_lat = params[:user][:user_lat]
        user_lng = params[:user][:user_lng]
        users=User.find(current_user.id)#.update(user_lat: user_lat, user_lng: user_lng)
        users.update_attributes(user_lat: user_lat, user_lng: user_lng)
        #users.user_lat=user_lat
        #users.user_lng=user_lng
        #users.save
        puts(users.errors.full_messages)
        redirect_to root_path
    end
    
    
    private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :profile_name, :email, :password, :password_confirmation, :avatar, :avatar_cache, :user_lat, :user_lng )
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :avatar, :avatar_cache, :user_lat, :user_lng )
  end
end
