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
        if UserFriendship.where(user_id: current_user, friend_id: params[:friend_id]).any? || UserFriendship.where(user_id: params[:friend_id], friend_id: current_user).any?
            flash[:error] = "You already have added this user."
            redirect_to current_user
        else
        
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
    
    def show
        @user = current_user
        @user.full_name
        if @user
            @friendships_friend = UserFriendship.where(friend_id: @user)
            @friendships_user = UserFriendship.where(user_id: @user)
            render action: :friendship_confirmation
        else
            render file: 'public/404', status: 404, formats: [:html]
        end
    end
    
    def update
        respond_to do |format|
            if @user_friendship.update(response_params)
                format.html { redirect_to profile_path(@user_friendship.user_id), notice: 'Friendship was successfully updated.' }
                format.json { render :show, status: :ok, location: @book }
            else
                format.html { render :edit }
                format.json { render json: @book.errors, status: :unprocessable_entity }
            end
        end
    end
    
    
    def accept
        if params[:id]
            puts params[:id]
        end
        @user = current_user
        @friendship = UserFriendship.find(friendship_params)
        
        respond_to do |format|
            if @friendship.update(state: "accepted")
                format.html { redirect_to profile_path(User.find(@friendship.friend_id).profile_name), notice: 'Congratulations, you have a new friend!' }
                format.json { render :show, status: :ok, location: @user_friendship }
            else
                format.html { render action: :friendship_confirmation }
            end
        end
    end
    
    def decline
        if params[:id]
            puts params[:id]
        end
        @user = current_user
        
        @friendship = UserFriendship.find(params[:id])
        
        @friend = User.find(@friendship.user_id)
        
        
        respond_to do |format|
            if UserFriendship.find(friendship_params).delete
                format.html { render action: :friendship_confirmation, notice: "You have declined "+@friend.full_name+"'s friends request." }
                format.json { render :show, status: :ok, location: @user_friendship }
            else
                format.html { render action: :friendship_confirmation }
            end
        end
    end
    
    
    private
    
    def friendship_params
        params.require(:id)
    end
    
end
