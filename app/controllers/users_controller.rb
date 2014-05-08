class UsersController < ApplicationController
  def create
  	@user = User.new(user_params)
  	if @user.save
      flash[:success] = "Welcome to the Sample App!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  rescue_from ActionController::ParameterMissing do
  	render 'new'
  end

  private 
  	def user_params
  		required_params = params.require(:user)
  		required_params.permit(:name, :email, :password, :password_confirmation)
  	end
end
