class UsersController < ApplicationController
  
  before_action :authenticate_user!

def show
  @user = User.find(params[:id])
  @user_current = current_user
  @books = @user.books
  @book_new = Book.new
end

def index
  @user = User.all
  @user_current = current_user
  @book_new = Book.new
end

def edit
  @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
end

def update
  @user = User.find(params[:id])
    if @user.update(user_params)
  flash[:notice] = 'You have updated user successfully.'
  redirect_to user_path(@user.id)
    else
      render "/users/edit"
    end
end

private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
end