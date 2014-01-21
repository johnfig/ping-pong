class User < ActiveRecord::Base
has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
													 :url  => "/assets/products/:id/:style/:basename.:extension",
					                 :path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"
end
