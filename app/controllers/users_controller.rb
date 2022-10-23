class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @book = @user.books
    @book_new = Book.new
  end

  def index
    @user = current_user
    @book_new = Book.new
    @users = User.all

  end

  def edit
    @user = User.find(current_user.id)
    @user.user_id = current_user.id

  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to user_path(@user.id)
      flash[:notice] = "You have updated user successfully."
    else
      render:edit
      flash[:notice] = "You have updated user error."
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:introduction, :profile_image)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(books_path) unless @user == current_user
  end

end
