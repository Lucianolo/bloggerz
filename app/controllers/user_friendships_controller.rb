class UserFriendshipsController < ApplicationController
    before_filter :authenticate_user!, only: [:new]
    
    def new
        if params[:friend_id]
            @friend = User.where(profile_name: params[:friend_id]).first
           
            raise ActiveRecord::RecordNotFound if @friend.nil?
            
            @user_friendship = current_user.user_friendships.new(friend: @friend)
        else
            flash[:error] = "Friend required"
        end
        
        rescue ActiveRecord::RecordNotFound
            render file: 'public/404', status: :not_found
        
    end
    
    def create
        
        @friend = User.where(profile_name: params[:user_friendship][:friend_id]).first
        
        # In caso un utente sia già tra le amicizie questo controllo impedisce di inviare una nuova richiesta
        if UserFriendship.where(user_id: current_user, friend_id: @friend).any? || UserFriendship.where(user_id: @friend, friend_id: current_user).any?
            flash[:notice] = "You already have added this user."
            redirect_to profile_path(current_user.profile_name)
            
        else
            if params[:user_friendship] && params[:user_friendship].has_key?(:friend_id)
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
      
        if @user
            @friendships_requested = UserFriendship.where(friend_id: current_user.id, state: "pending")
            @actual_friendships_user = UserFriendship.where(user_id: current_user.id, state: "accepted")
            @actual_friendships_friend = UserFriendship.where(friend_id: current_user.id, state: "accepted")
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
        @user = current_user
        @friendship = UserFriendship.find(friendship_params)
        
        respond_to do |format|
            if @friendship.update(state: "accepted")
                format.html { redirect_to :friendships , notice: 'Congratulations, you have a new friend!' }
                format.json { render :show, status: :ok, location: @user_friendship }
            else
                format.html { render action: :friendship_confirmation }
            end
        end
    end
    
    def decline
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
    
    def destroy
        @friend_id = User.where(profile_name: params[:id]).first
        @friendship_friend = UserFriendship.where(user_id: @friend_id, friend_id: current_user).first
        @friendship_user = UserFriendship.where(user_id: current_user, friend_id: @friend_id).first
        if !@friendship_friend.nil?
            @friendship_friend.destroy
        else
            @friendship_user.destroy
        end
        flash[:notice] = "Successfully destroyed friendship."
        redirect_to root_url
    end
    
    
    private
    
    def friendship_params
        params.require(:id)
    end
    
end
