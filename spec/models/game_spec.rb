require 'spec_helper'

describe Game do
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

	let(:user_3)  { FactoryGirl.create :user, first_name: "This", 
  																					last_name: "Guy", 
  																					username: "thisGuy", 
  																					password: "password", 
  																					password_confirmation: "password"
  																				 }
  
  let(:user_4)  { FactoryGirl.create :user, first_name: "John", 
  																					last_name: "Smith", 
  																					username: "johnSmith", 
  																					password: "password", 
  																					password_confirmation: "password"
  																				 }
  let(:game)		{ FactoryGirl.create :game, winner_id: user_1.id, loser_id: user_2.id }

	context "#users score should change with weighted averages" do
		it "If expected winner wins, weighted average should be 0.5 and winner gets 5 points" do
			ap user_1
			ap user_2
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

		it "Should change score based on the weighted average if user_2 beats user_1 in first game" do
			user_1
			user_2
			user_3
			user_4
			game_1 = FactoryGirl.create :game, winner_id: user_2.id, loser_id: user_1.id

			user_2.ranking.reload.score.should == 12
			user_1.ranking.reload.score.should == -6
		end
	end
end