class SiteController < ApplicationController

  def index
		@favorites = Favorite.active.all
		@section = current_user.sections.build unless current_user.blank?
  end
end
