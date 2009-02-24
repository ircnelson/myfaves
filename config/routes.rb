ActionController::Routing::Routes.draw do |map|
	map.login "/login", :controller => 'users', :action => 'login'
	map.logout "/logout", :controller => 'users', :action => 'logout'
	map.site '/', :controller => 'site'
  map.resources :sections do |section|
  	section.resources :favorites
  end

	map.resources :users do |user|
		user.resources :sections do |section|
			section.resources :favorites
		end
	end
	
  map.root :controller => 'site'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
