class AddScoreDefaultZeroToRankings < ActiveRecord::Migration
  def change
  	remove_column :rankings, :score
  	add_column :rankings, :score, :integer, :default => 0 
  end
end
