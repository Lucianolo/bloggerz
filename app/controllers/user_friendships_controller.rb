class UserFriendshipsController < ApplicationController
    before_filter :authenticate_user!, only: [:new]
    
    def new
        if params[:friend_id]
            @friend = User.where(profile_name: params[:friend_id]).first
            
            raise ActiveRecord::RecordNotFound if @friend.nil?
            
            @user_friendship = current_user.user_friendships.new(friend: @friend)
            flash[:success] = "Ask #{@friend.full_name} for friendship!"
        else
            flash[:error] = "Friend required"
        end
        
        rescue ActiveRecord::RecordNotFound
            render file: 'public/404', status: :not_found
        
    end
    
    def create
        if params[:user_friendship] && params[:user_friendship].has_key?(:friend_id)
            @friend = User.where(profile_name: params[:user_friendship][:friend_id]).first
            @user_friendship = current_user.user_friendships.new(friend: @friend)
            
            if @user_friendship.save
                @user_friendship.update(state: "pending")
            
            
            #UserNotifier.friend_requested(@user_friendship).deliver_now
                flash[:success] = "You have sent a friends request to #{@friend.full_name}"
                redirect_to profile_path(@friend)
            end
        else
            flash[:error] = "Friend required"
            redirect_to root_path
        end
    end
end
