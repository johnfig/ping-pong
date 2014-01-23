require 'spec_helper'

describe Ranking do
  let(:user_1)  { FactoryGirl.create :user, first_name: "John", 
  																					last_name: "Fig", 
  																					username: "johnfig", 
  																					password: "password", 
  																					password_confirmation: "password"
  																					 }
  let(:user_2)  { FactoryGirl.create :user, first_name: "Hello", 
  																					last_name: "World", 
  																					username: "HelloWorld", 
  																					password: "password", 
  																					password_confirmation: "password"
  																				 }
  let(:game)		{ FactoryGirl.create :game, winner_id: user_1.id, loser_id: user_2.id }

	context "#users score should change with weighted averages" do
		it "Games outside of 4 weeks should not affect score or ranking" do
			old_game = FactoryGirl.create :game, winner_id: user_1.id, loser_id: user_2.id, created_at: Time.now - 5.weeks

			user_1
			user_2
			game
	
			user_1.ranking.reload.score.should == 5
			user_2.ranking.reload.score.should == -2	
		end

		it "Should change rankings if user_2 beats user_1 in first game" do
			user_1
			user_2
			game_2 = FactoryGirl.create :game, winner_id: user_2.id, loser_id: user_1.id
			game_3 = FactoryGirl.create :game, winner_id: user_2.id, loser_id: user_1.id

			user_2.ranking.reload.ranking.should == 1
			user_1.ranking.reload.ranking.should == 2
		end
	end
end