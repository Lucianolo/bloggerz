class UserNotifier < ActionMailer::Base
    
    default from: 'groupbooooks@gmail.com'
 
    def welcome_email(user)
        @user = user
        @url  = 'https://bloggerz-lucianolo.c9users.io/login'
        mail(to: @user.email, subject: 'Welcome to GroupBooks!')
    end
    
    
    def friend_requested(user_friendship_id)
        
        #user_friendship = UserFriendship.find_by_id(user_friendship_id)
        #puts user_friendship_id.user
        @user = user_friendship_id.user
        @friend = user_friendship_id.friend
        puts @user.email
        mail to: @friend.email,
            subject: "#{@user.first_name} sent you a friends request!"
    end
    
    def friend_request_accepted(user_friendship_id)
        user_friendship = UserFriendship.find(user_friendship_id)
        
        @user = user_friendship.user
        @friend = user_friendship.friend
        
        mail to: @user.email,
            subject: "#{@friend.first_name} has accepted your friends request!"
    end
end

