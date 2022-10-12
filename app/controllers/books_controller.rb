class BooksController < ApplicationController
  protect_from_forgery
  before_action :correct_user, only: [:edit, :update]

  def show
    @book = Book.find(params[:id])
    @user = current_user
    @book_new = Book.new
  end

  def index
    @user = current_user
    @book = Book.all
    @book_new = Book.new
  end

  def edit
   @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
       flash[:notice] = "You have created book successfully."
       redirect_to book_path(@book.id)
    else
      render:new
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    @book.destroy
    redirect_to books_path

  end

  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @Book.update(user_params)
       redirect_to user_path
       flash[:notice] = "You have updated book successfully."
    else
      render:edit
    end
  end

private
  def book_params
    params.require(:book).permit(:title, :body, :image, :caption)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end

end
