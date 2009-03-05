# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
	include AuthSystem
  helper :all
  protect_from_forgery

	before_filter :login_required
  protected
		def login_required
			unless logged_in?
				redirect_to login_path
			end
		end
		
		def redirect_with_flash(url = nil, flash_message = {})
			url ||= root_path
			redirect_to url
			flash_message
		end
	
end
