class UsersController < ApplicationController
  def create
  	@user = User.new(user_params)
  end

  private 
  	def user_params
  		params.require(:name).require(:email).permit(:password, :password_confirmation)
  	end
end
