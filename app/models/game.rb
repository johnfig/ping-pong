class Game < ActiveRecord::Base
	after_create :update_scores

	validate :winner_does_not_equal_loser

	private

	def winner_does_not_equal_loser 
		errors.add(:base, "You can't play yourself silly") if self.winner_id == self.loser_id
	end

	def update_scores
		@loser = User.find(self.loser_id)
		@winner = User.find(self.winner_id)
	
		calculate_expected_outcome(@loser, @winner)

		self.winner_score += 10 * @weighted_average
		self.loser_score -= 5 * @weighted_average
		self.save

		Ranking.update_score
		update_rankings
	end

	def calculate_expected_outcome(loser, winner)
		if winner.ranking.ranking < loser.ranking.ranking 
			@expected_winner = winner 
			@expected_loser = loser
			calculate_weighted_average(@expected_loser, @expected_winner, true)
		elsif winner.ranking.ranking > loser.ranking.ranking 
		  @expected_winner = loser
			@expected_loser = winner
			calculate_weighted_average(@expected_loser, @expected_winner, false)
		end
	end

	def calculate_weighted_average(expected_loser, expected_winner, predicted_outcome)
		user_count = User.all.count

		if predicted_outcome == true
			@weighted_average = ((expected_winner.ranking.ranking - expected_loser.ranking.ranking).to_f.abs  / user_count).to_f
			return @weighted_average
		else
			@weighted_average = 1 + ((expected_winner.ranking.ranking - expected_loser.ranking.ranking).to_f.abs / user_count.to_f)
			return @weighted_average
		end
	end

	def update_rankings
		@rankings = Ranking.all
		@rankings.order!("score desc")
		ranking = 1
		@rankings.each do |x|
			x.update(ranking:ranking)
			ranking += 1
		end
	end
end
