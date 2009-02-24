class SiteController < ApplicationController
  def index
		@sections = Section.all
  end

end
