class AddScoreAndRankingToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :ranking, :integer
  	add_column :users, :score, :integer, :default => 0 
  	add_column :users, :user_id, :integer
  end
end
