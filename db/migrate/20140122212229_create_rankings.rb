class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.integer :score
      t.integer :ranking

      t.timestamps
    end
  end
end
