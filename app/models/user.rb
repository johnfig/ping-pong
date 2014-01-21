class User < ActiveRecord::Base

after_save :update_rankings

has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
													 :url  => "/assets/products/:id/:style/:basename.:extension",
					                 :path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"

validates_attachment_presence :avatar
validates_attachment_size :avatar, :less_than => 5.megabytes
validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']
validates :first_name, 						presence: true
validates :last_name, 						presence: true
validates :username,						  presence: true,
																	uniqueness: true
validates :password, 							presence: true,
																	:length => { :minimum => 5, :maximum => 40 },
                    							:confirmation => true
validates :password_confirmation, presence: true

private 
	def update_rankings
		if self.ranking == nil
			@users = User.all
			@users.order("score desc")
			ranking = 1
			@users.each do |x|
				x.update(ranking:ranking)
				ranking += 1
			end
		end
	end
end
