require 'digest/sha1'
class User < ActiveRecord::Base

	AVATAR_SW = 80
  AVATAR_SH = 80
  AVATAR_NW = 240
  AVATAR_NH = 240
  
  has_attached_file :avatar,
        :styles => { :normal => ["#{AVATAR_NW}x#{AVATAR_NH}>", :jpg],
                     :small => ["#{AVATAR_SW}x#{AVATAR_SH}", :jpg] },
        :convert_options => { :all => "-strip",
                              :normal => proc { |m| m.avatar_crop_str },
                              :small => proc { |m| m.avatar_crop_str } },
        :processors => [:jcropper],
        :default_url => "/images/default_avatar.png"

  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png']
  
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  
  def avatar_crop_str
    if !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
      "-crop #{crop_w}x#{crop_h}+#{crop_x}+#{crop_y}"
    else
      ""
    end
  end
  
  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file avatar.path(style)
  end

	include Authentication
	validates_presence_of :email
	validates_uniqueness_of :email
	has_many :sections
	after_create :create_faves_root
	
	def create_faves_root
		if self.sections.blank?
			sections.create(:name => "All")
		end
	end
	
	acts_as_state_machine :initial => :step_one
	state :step_one
	state :step_two
	state :step_three
	state :finished
	
	event :step_one do
    transitions :from => [:step_two, :step_three], :to => :step_one
  end
  
  event :step_two do
  	transitions :from => [:step_one, :step_three], :to => :step_two
  end
  
  event :step_three do
  	transitions :from => [:step_one, :step_two], :to => :step_three
  end
  
  event :finish do
  	transitions :from => [:step_one, :step_two, :step_three], :to => :finished
  end
end
