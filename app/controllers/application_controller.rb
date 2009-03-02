# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
	include AuthSystem
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

	before_filter :login_required

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  protected
		def login_required
			unless logged_in?
				redirect_to login_path
			end
		end
		
		def redirect_with_flash(url, flash_message = {})
			url ||= site_path
			redirect_to url
			flash_message
		end
end
