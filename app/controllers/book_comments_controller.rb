class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @comment_new = current_user.book_comments.new(book_comment_params)
    @comment_new.book_id = @book.id
    @comment_new.save
      # redirect_to @book
    # else
      # @book_new = Book.new
      # render "books/show"
    # end
  end

  def destroy
    # session[:previous_url] = request.referer
    @book = Book.find(params[:book_id])
    @comment_new = BookComment.new
    @book_comment = BookComment.find_by(book_id: params[:book_id], id: params[:id])
    if @book_comment.user = current_user
      @book_comment.destroy
    end
    # redirect_to session[:previous_url]
    # session.delete(:previous_url)
   end

  private
    def book_comment_params
      params.require(:book_comment).permit(:comment)
    end
end
