class SiteController < ApplicationController
  def index
		@favorites = Favorite.active.all
		@section = current_user.sections.build
  end

end
