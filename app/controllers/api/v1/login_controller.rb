class Api::V1::LoginController < ApplicationController

  before_action :set_user

  def create

     

    if @user&.valid_password?(params[:user][:password])
      render json: @user.authentication_token
    else
      head(:unauthorized)
      #render json: @user
    end

  end

  private
 
  def set_user

    #binding.pry
    @user = User.where(email: params[:user][:email]).take

  end

  def login_params
  
    params.require(:user).permit(:email, :password)

  end

end
