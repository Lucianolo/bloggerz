require 'pusher'

pusher = Pusher::Client.new app_id: '198977', key: '29b6be3ff7a1ec4e6c93', secret: '4ea32977e10860333c49'

# trigger on my_channel' an event called 'my_event' with this payload:

pusher.trigger('my_channel', 'my_event', {
    message: 'hello world'
})