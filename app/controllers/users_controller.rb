class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @users = User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @followed_sides = @user.followed_sides
    @follower_sides = @user.follower_sides
  end


  def edit
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to  user_path(current_user)
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

# フォロー一覧
  def follows
  user = User.find(params[:id])
  @users = user.followed_sides
  end

# フォロワー一覧
  def followers
  user = User.find(params[:id])
  @user = user.follower_sides
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
