class Api::V1::GamesController < ApplicationController
def create
		params[:winner_id] = params[:winner_id].to_i
		params[:loser_id] = params[:loser_id].to_i

    @game = Game.new(winner_id: params[:winner_id], loser_id: params[:loser_id])
    loser = User.find(params[:loser_id])
    winner = User.find(params[:winner_id])
    @game.update(winner_ranking: winner.ranking, loser_ranking: loser.ranking)

    if @game.save
    	success_hash =  { success: 'success', message: 'Congrats, your game was successfully logged!' }
      render json: success_hash
    else
    	failure_hash =  { failure: 'failure', message: 'Oh no. Something happened and this game was not saved!' }
      render json: failure_hash
    end
  end
end