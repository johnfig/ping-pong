class User < ActiveRecord::Base
	
	# associations
	has_one :ranking

	# validations
	validate :password_confirmation_should_equal_password

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

  # callbacks
	after_create :create_ranking

  private

  def password_confirmation_should_equal_password
  	errors.add(:base, "Password needs to be the same silly") if self.password != self.password_confirmation
	end								 										

	def create_ranking
		Ranking.create!(ranking: User.count, user_id: id)
	end
end
