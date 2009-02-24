module Authentication
	def self.included(recipient)
    recipient.class_eval do
			attr_accessor :password
			validates_presence_of :password, :if => :password_required?
			validates_presence_of :password_confirmation, :if => :password_required?
			validates_confirmation_of :password
			before_save :encrypt_password

			def self.authenticate(login, password)
				return nil if login.blank? || password.blank?
				u = find :first, :conditions => { :email => login } #check login by email
				u && u.authenticated?(password) ? u : nil
			end
	
			def authenticated?(password)
				crypted_password == encrypt(password)		
			end

			private
			def encrypt_password
				return if password.blank?
				self.crypted_password = encrypt(password)
			end
	
			def encrypt(arg)
				Digest::SHA1.hexdigest(arg)
			end
	
			def password_required?
				self.crypted_password.blank? || !password.blank?
			end
		end
	end
end
