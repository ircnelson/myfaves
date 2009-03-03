class UsersController < ApplicationController

	before_filter :find_user, :only => [:edit, :avatar, :crop, :update, :destroy]
	# TODO: before_filter :check_user_step
	skip_before_filter :login_required, :only => [:login, :new, :create]

	def show
	end
	
	def new
		@user = User.new
	end
	
	def create
		kill_session
		@user = User.new(params[:user])
		if @user.save && @user.errors.empty?
			@user.step_two!
			self.current_user = @user
			redirect_to user_path(@user)
		else
			render :action => :new
		end
	end

	def edit
	end

	def update
		@user.update_attributes(params[:user]) ? redirect_to(@user) : render(:action => :edit)
	end
	
	def login
		redirect_to root_path if logged_in?
		if request.post?
			return if params[:login].blank? || params[:password].blank?
			@user = User.authenticate(params[:login], params[:password])
			if @user.nil?
				login_path
			else
				self.current_user = @user
				redirect_with_flash root_path, flash[:notice] = "You are logged now."
			end
		end
	end

	def avatar
	end
	
	def crop
		if request.post?
		  if @user.update_attributes(params[:user])
		    @user.avatar.reprocess!
		  end
		  redirect_to user_path(@user)
		end
  end

	def logout
		kill_session if logged_in?
		redirect_with_flash root_path, flash[:warning] = "Thanks!"
	end
	
	protected
		def find_user
			@user = User.find(current_user.id)
		end
		
		def check_user_step
		end

end
