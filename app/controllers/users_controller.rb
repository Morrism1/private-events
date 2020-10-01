class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Please confirm your email address to continue"
      redirect_to events_path
    else
      flash[:error] = "Ooooppss, something went wrong!"
      render 'new'
    end
  end

  def show; end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
