class FavoritesController < ApplicationController

  before_filter :find_favorite

  FAVORITES_PER_PAGE = 20

  def create
    @favorite = @section.favorites.build(params[:favorite])
    respond_to do |format|
      if @favorite.save
        flash[:notice] = 'Favorite was successfully created.'
        format.html { redirect_to(@section, @favorite) }
        format.xml  { render :xml => @favorite, :status => :created, :location => @favorite }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @favorite.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @favorite.destroy
        flash[:notice] = 'Favorite was successfully destroyed.'        
        format.html { redirect_to section_favorites_path(@section) }
        format.xml  { head :ok }
      else
        flash[:error] = 'Favorite could not be destroyed.'
        format.html { redirect_to(@section, @favorite) }
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index
    @favorites = @section.favorites.paginate(:page => params[:page], :per_page => FAVORITES_PER_PAGE)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @favorites }
    end
  end

  def edit
  end

  def new
    @favorite = @section.favorites.build
    respond_to do |format|
      format.html
      format.xml  { render :xml => @favorite }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @favorite }
    end
  end

  def update
    respond_to do |format|
      if @favorite.update_attributes(params[:favorite])
        flash[:notice] = 'Favorite was successfully updated.'
        format.html { redirect_to @favorite.section }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @favorite.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def find_favorite
  	@section = Section.find(params[:section_id])
    @favorite = @section.favorites.find(params[:id]) if params[:id]
  end

end
