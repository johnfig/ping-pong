class Game < ActiveRecord::Base
	before_save :set_player_rankings





	private

	def set_player_rankings
		puts self.inspect
		puts self.winner_id
		puts self.loser_id
		winner = User.find(self.winner_id)
		loser = User.find(self.loser_id)
		# self.update(winner_ranking: 1, loser_ranking: 2)

		# self.update_attribute(:winner_ranking, winner.ranking)
		# self.update_attribute(:loser_ranking, loser.ranking)
		# puts self.inspect
		# puts "Winner ranking: #{winner_ranking}"
		# puts "Loser ranking: #{loser_ranking}"
		# ap self
	end
end
