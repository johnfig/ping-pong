class Api::V1::LoginController < ApplicationController
	skip_before_filter :verify_authenticity_token 
	
	# post
	def create
		if @user = User.find_by(username: params[:username], password: params[:password])
			success_hash = {
				success: 'success',
				message: 'You have successfully logged in!'
			}
			render json: success_hash
		else 	
			failure_hash = {
				failure: 'failure',
				message: 'User cannot be found'
			}
			render json: failure_hash
		end
	end	

	private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:username, :password)
  end
end