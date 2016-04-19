require 'pusher'

Pusher.app_id = '198977'
Pusher.key = '29b6be3ff7a1ec4e6c93'
Pusher.secret = '4ea32977e10860333c49'
Pusher.cluster = 'eu'
Pusher.logger = Rails.logger
Pusher.encrypted = true

# app/controllers/hello_world_controller.rb
class HelloWorldController < ApplicationController
  def hello_world
    Pusher.trigger('test_channel', 'my_event', {
      message: 'hello world'
    })
  end
end