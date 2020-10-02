class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]
  before_action :authenticate_user!, only: [:index, :show, :edit, :followers, :followings]

  def index
    @users = User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to current_user
    end
  end

  def update
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to @user
    end

    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def followers
    @user = User.find(params[:user_id])
  end

  def followings
    @user = User.find(params[:user_id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
