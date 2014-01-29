class Api::V1::LeaderboardController < ApplicationController
  def index
    @users = User.ordered_ranked_list
    leaderboard_array = @users.map do |user|
    	user_push = {
    		first_name: user.first_name,
    		last_name: user.last_name,
    		username: user.username,
    		ranking: user.ranking,
    		photo: user.avatar.url
    		}

    	user_push
    end
    render json: leaderboard_array
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :password, :password_confirmation, :ranking, :avatar)
  end
end
