class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
  end

  def create
    @user = User.new params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    if @user.save
      flash.delete(:warning)
      redirect_to posts_path
    else
      flash[:warning] = "unable to create user"
      render :new
    end
  end

  def edit
    @user = current_user 
  end

  def update
    @user = current_user
    user_params = params[:user]
    if (current_user.authenticate(user_params[:current_password])) 
      if (user_params[:new_password] == user_params[:new_password_confirmation])
        if @user.update({password: user_params[:new_password]})
          flash[:success] = "password updated"
          redirect_to root_path
        else
          flash[:danger] = "password not updated"
          render :edit
        end
      end
    end
  end
end