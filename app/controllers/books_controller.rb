class BooksController < ApplicationController
  protect_from_forgery

  def show
    @book = Book.find(params[:id])
  end

  def index
    @user = current_user
    @book = Book.all
    @book_new = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
  end

  def destroy
    @book = Book.find(params[:id])
    @book = @book.destroy
    redirect_to books_path
  end

  def update
  end

private
  def book_params
    params.require(:book).permit(:title, :body, :image, :caption)
  end

end
