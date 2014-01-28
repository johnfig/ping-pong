class Api::V1::GamesController < ApplicationController
def create
    @game = Game.new
    loser = User.find(params[:loser_id])
    winner = User.find(params[:winner_id])
    @game.update(winner_ranking: winner.ranking, loser_ranking: loser.ranking)

    if @game.save
    	failure_hash =  { success: 'success', message: 'Congrats, your game was successfully logged!' }
      render json: leaderboard_array
    else
    	failure_hash =  { failure: 'failure', message: 'Oh no. Something happened and this game was not saved!' }
      render json: failure_hash
    end
  end
end