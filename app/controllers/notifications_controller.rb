
class NotificationsController < ApplicationController
    require 'sinatra'
    def index
        pusher.trigger('notifications', 'new_notification', {
            message: 'hello world'
        })
        redirect_to root_path
    end
    
    
end