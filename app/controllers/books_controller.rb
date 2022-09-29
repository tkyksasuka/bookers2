class BooksController < ApplicationController
  def new
     @book = Book.new
  end

  def show
  end

  def index
  end

  def edit
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to user_path(current_user.id)
  end

  def destroy
  end

  def update
  end

private
  def book_params
    params.require(:book).permit(:title, :body, :image, :caption)
  end  

end
