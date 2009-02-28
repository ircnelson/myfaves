class Section < ActiveRecord::Base
	acts_as_nested_set
	include NestedSetList
	has_many :favorites, :dependent => :destroy
	belongs_to :user
	after_save :check_if_exists_parent_and_move
	validates_presence_of :name
	
	attr_accessor :children_of
	
	private
	
		def check_if_exists_parent_and_move
			unless self.children_of.nil?
				self.move_to_child_of(self.children_of)
			end
		end

end
