class DeleteRankingAndScoreFromUserTable < ActiveRecord::Migration
  def change
  	remove_column :users, :ranking
  	remove_column :users, :score
  end
end
