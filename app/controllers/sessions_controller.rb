class SessionsController < ApplicationController
  def new
      @user=User.new
  end
  def create
      @user = User.find_by_email params[:email]
      if  @user && @user.authenticate(params[:password])
      
          session[:user_id]=@user.id
          
          redirect_to root_path, notice: 'Logged in'
      else
          flash[:alert]= 'Wrong email or password.'
          render :new
      end

      def update_without_password(params, *options)
          params.delete(:password)
          params.delete(:password_confirmation)
        
          result = update_attributes(params, *options)
          clean_up_passwords
          result
        end

  end
  def destroy
      session[:user_id]=nil
      redirect_to root_path, notice: 'Logged Out!'
  end
end
