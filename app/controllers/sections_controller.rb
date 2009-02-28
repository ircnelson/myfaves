class SectionsController < ApplicationController

	before_filter :login_required
  before_filter :find_section

  def create
    @section = @user.sections.build(params[:section])
    respond_to do |format|
      if @section.save
        flash[:notice] = 'Section was successfully created.'
        format.html { redirect_to @section }
        format.xml  { render :xml => @section, :status => :created, :location => @section }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @section.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @section.destroy
        flash[:notice] = 'Section was successfully destroyed.'        
        format.html { redirect_to sections_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Section could not be destroyed.'
        format.html { redirect_to @section }
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index
    @sections = @user.sections.all
    respond_to do |format|
      format.html
      format.xml  { render :xml => @sections }
    end
  end

  def edit
  end

  def new
    @section = @user.sections.build
    respond_to do |format|
      format.html
      format.xml  { render :xml => @section }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @section }
    end
  end

  def update
    respond_to do |format|
      if @section.update_attributes(params[:section])
        flash[:notice] = 'Section was successfully updated.'
        format.html { redirect_to @section }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @section.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

		def find_section
			@user = User.find(current_user.id) if current_user
			@section = @user.sections.find(params[:id]) if params[:id]
		end

end
