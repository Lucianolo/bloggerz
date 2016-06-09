
class NotificationsController < ApplicationController
    require 'sinatra'
    
    before_filter :authenticate_user!
    
    def index
        pusher.trigger('notifications', 'new_notification', {
            message: 'hello world'
        })
        redirect_to root_path
    end
    
    
end