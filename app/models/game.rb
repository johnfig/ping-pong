class Game < ActiveRecord::Base
	before_save :update_scores

	private

	def update_scores
		@loser = User.find(self.loser_id)
		@winner = User.find(self.winner_id)
		
		calculate_expected_outcome(@loser, @winner)

		puts "Updated_scores weighted_average: #{@weighted_average}"
		@winner.score += 10 * @weighted_average
		@winner.save
		@loser.score -= 5 * @weighted_average
		@loser.save

		update_rankings
	end

	def calculate_expected_outcome(loser, winner)
		if winner.ranking < loser.ranking 
			@expected_winner = winner 
			@expected_loser = loser
			calculate_weighted_average(@expected_loser, @expected_winner, true)
		elsif winner.ranking > loser.ranking 
		  @expected_winner = loser
			@expected_loser = winner
			calculate_weighted_average(@expected_loser, @expected_winner, false)
		end
	end

	def calculate_weighted_average(expected_loser, expected_winner, predicted_outcome)
		user_count = User.all.count

		if predicted_outcome == true
			@weighted_average = 1 * ((expected_winner.ranking - expected_loser.ranking).to_f.abs  / user_count).to_f
			return @weighted_average
		else
			@weighted_average = 1 + ((expected_winner.ranking - expected_loser.ranking).to_f.abs / user_count.to_f)
			return @weighted_average
		end
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
