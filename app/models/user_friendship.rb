class UserFriendship < ActiveRecord::Base
    resourcify
    belongs_to :user
    belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'
    
    
    #State Machine ci permette di assegnare uno stato alla UserFriendship 
    # in modo tale da permettere a un utente di accettare o meno.
    #state_machine :state, initial: :pending do
    #    after_transition on: :accept, do: :send_acceptance_email
    #    
    #    event :accept do
    #        transition any => :accepted
    #    end
    #end
    
    
    # per inviare le mail di richiesta amicizia dobbiamo prima generare un mailer :
    # rails generate mailer user_notifier
    # Definiamo poi il metodo usato:
    


    
    def send_request_email
        UserNotifier.friend_requested(self).deliver_now
    end
    
    def send_acceptance_email
        UserNotifier.friend_request_accepted(self).deliver_now
    end
    
end
