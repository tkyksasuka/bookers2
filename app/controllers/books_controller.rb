class BooksController < ApplicationController
  protect_from_forgery
  before_action :correct_user, only: [:edit, :update]

  def show
    @book = Book.find(params[:id])
    @user = @book.user
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
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    if @book_new.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book_new.id)
    else
      @user = current_user
      @book = Book.all
      render :index   #indexに飛びたい
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
    if @book.update(book_params)
       redirect_to book_path(@book.id)
       flash[:notice] = "You have updated book successfully."
    else
      render :edit
      flash[:notice] = "You have updated book error."
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
