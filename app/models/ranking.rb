class Ranking < ActiveRecord::Base

	# associations
	has_one :user

	def display_score
		[score, 0].max
	end

	def self.update_score
		@users = User.all
		@games = Game.where("created_at > ?", Time.now - 4.weeks)

		@users.each do |user|
			total_score = 0
			@games.each do |game|
				if user.id == game.loser_id
					total_score = total_score + game.loser_score
				elsif user.id == game.winner_id
					total_score = total_score + game.winner_score
				end
			end
			user.ranking.update(score: total_score)
		end
	end
end
