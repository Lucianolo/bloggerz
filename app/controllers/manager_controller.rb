class ManagerController < ApplicationController
    before_filter :authenticate_user!, only: [:upgrade, :downgrade]
    
    def upgrade
        if current_user.has_role? :manager
            user=User.where(id: params[:id]).first
            user.roles.first.update(:name=>"moderator")
            flash[:notice] = "Operation success."
            redirect_to :back
        else
            flash[:alert] = "You haven't got the permissions to edit this book."
            redirect_to :back
        end
    end
    
    def downgrade
        if current_user.has_role? :manager
            user=User.where(id: params[:id]).first
            user.roles.first.update(:name=>"user")
            flash[:notice] = "Operation success."
            redirect_to :back
        else
            flash[:alert] = "You haven't got the permissions to edit this book."
            redirect_to :back
        end
    end
    
end
