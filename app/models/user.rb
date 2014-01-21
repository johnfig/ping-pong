class User < ActiveRecord::Base
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
end
