class CommentsController < ApplicationController
    
    before_filter :authenticate_user!, only: [:create, :destroy]
    before_action :set_book
    
    
    
    def create  
      @comment = @book.comments.build(comment_params)
      @comment.user_id = current_user.id
    
      if @comment.save
        flash[:success] = "You commented the hell out of that book!"
        redirect_to :back
      else
         redirect_to :back
      end
    end
    
    def destroy  
      @comment = @book.comments.find(params[:id])
    
      @comment.destroy
      flash[:success] = "Comment deleted :("
      redirect_to :back
    end  
    
    private
    
    def comment_params  
      params.require(:comment).permit(:content)
    end
    
    def set_book  
      @book = Book.find(params[:book_id])
    end  

end