class UsersController < ApplicationController

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
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
    #@user.user_id = current_user.id
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice] = "You have updated user successfully."
    else
      render:edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:introduction, :profile_image)
  end


end
