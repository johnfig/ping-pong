class AddPlayerRankingsToGames < ActiveRecord::Migration
  def change
  	add_column :games, :winner_ranking, :integer
  	add_column :games, :loser_ranking, :integer
  end
end
