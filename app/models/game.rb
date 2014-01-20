class Game < ActiveRecord::Base
	before_save :update_scores

	private

	def update_scores
		@loser = User.find(self.loser_id)
		@winner = User.find(self.winner_id)
		
		calculate_expected_outcome(@loser, @winner)

		@winner.score += 10
		@winner.save
		@loser.score -= 5 
		@loser.save

		update_rankings
	end

	def calculate_expected_outcome(loser, winner)
		# if winner.ranking < loser.ranking 
		# 	@expected_winner = winner 
		# 	@expected_loser = loser
		# 	calculate_weighted_average(@expected_loser, @expected_winner)
		# elsif winner.ranking > loser.ranking 
		#   @expected_winner = loser
		# 	@expected_loser = winner
		# 	calculate_weighted_average(@expected_loser, @expected_winner)
		# end
	end

	def calculate_weighted_average(expected_loser, expected_winner)
		# @expected_winner_weighted_average =  expected_loser
		# @expected_loser_weighted_average = 
	end

	def update_rankings
		@users = User.all
		@users.order!("score desc")
		ranking = 1
		@users.each do |x|
			x.update(ranking:ranking)
			ranking += 1
		end
	end
end
