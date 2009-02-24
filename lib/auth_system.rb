module AuthSystem
	protected
		def logged_in?
			!!current_user
		end
	
		def current_user=(user)
			session[:user_id] = user ? user.id : nil
			@current_user = user || false
		end
	
		def current_user
			@current_user ||= (login_from_session || login_from_basic_auth) unless @current_user == false
		end
	
		def self.included(base)
			base.send :helper_method, :current_user, :logged_in? if base.respond_to? :helper_method
		end
		
		def login_from_session
			self.current_user = User.find_by_id(session[:user_id]) if session[:user_id]
		end

		def login_from_basic_auth
			authenticate_with_http_basic do |login, password|
				self.current_user = User.authenticate(login, password)
		  end
		end
		
		def kill_session
			session[:user_id] = nil
			@current_user = nil
		end
end
