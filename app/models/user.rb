require 'digest/sha1'
class User < ActiveRecord::Base
	include Authentication
	validates_presence_of :email
	validates_uniqueness_of :email
	has_many :sections
	after_create :create_faves_root
	
	def create_faves_root
		if self.sections.blank?
			sections.create(:name => "main")
		end
	end
end
