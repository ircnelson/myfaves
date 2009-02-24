class UsersController < ApplicationController

	before_filter :find_user, :only => [:show]
	before_filter :find_current_user => [:edit, :update]
	before_filter :login_required, :only => [:edit, :update, :destroy]

	def show
	end
	
	def new
		@user = User.new
	end
	
	def create
		kill_session
		@user = User.new(params[:user])
		if @user.save && @user.errors.empty?
			self.current_user = @user
			redirect_to user_path(@user)
		else
			render :action => :new
		end
	end

	def edit;	end

	def update
		@user.update_attributes(params[:user]) ? redirect_to(@user) : render(:action => :edit)
	end
	
	def login
		redirect_to site_path if logged_in?
		if request.post?
			return if params[:login].blank? || params[:password].blank?
			@user = User.authenticate(params[:login], params[:password])
			if @user.nil?
				login_path
			else
				self.current_user = @user
				redirect_with_flash site_path, flash[:notice] = "You are logged now."
			end
		end
	end

	def logout
		kill_session if logged_in?
		redirect_with_flash site_path, flash[:warning] = "Thanks!"
	end
	
	protected
		def find_user
			if params[:login]
				@user = User.find_by_login(params[:login])
			else
				@user = User.find(params[:id])
			end
			rescue ActiveRecord::RecordNotFound
				#TODO: I18n -> User not found
				redirect_with_flash site_path, flash[:notice] = "User not found."
		end
		
		def find_current_user
			@user = User.find(current_user.id)
		end

end
