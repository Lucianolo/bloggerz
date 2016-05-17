class SwapsController < ApplicationController
    
    def new
    end
    
    def create
        book = Book.where(id: params[:book_id]).first
        if current_user
            user_id = current_user.id
            other_id = book.user_id
            book_id = book.id
            other_book_id = params[:other_book]
            @swap = Swap.new(user_id: user_id,other_id: other_id,book_id: book_id,other_book_id: other_book_id, status:"pending" )
            
            if @swap.save
                flash[:success] = "You have sent a Book swap request "
                redirect_to root_path
            end
        end

    end
    
    def accept
    end
    
    def decline
    end
    
    
    private
    
    def swap_params
        params.require(:book).permit(:book_id, :other_book_id)
    end
end
