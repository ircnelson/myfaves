class Favorite < ActiveRecord::Base
  belongs_to :section
  validates_presence_of :url
  named_scope :active, :conditions => { :state => true }
end
