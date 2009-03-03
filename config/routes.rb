ActionController::Routing::Routes.draw do |map|
	map.login '/login', :controller => 'users', :action => 'login'
	map.logout '/logout', :controller => 'users', :action => 'logout'
	map.register '/register', :controller => 'users', :action => 'new'
	map.avatar '/users/:id/edit/avatar', :controller => 'users', :action => 'avatar'
  map.resources :sections do |section|
  	section.resources :favorites
  end

	# TODO: organizar as etapas do registro: 1 -> email e senha; 2 -> avatar; 3 -> ...
	map.resources :users, :member => { :crop => :post, :step_one => :any, :step_two => :any, :step_three => :any } do |user|
		user.resources :sections do |section|
			section.resources :favorites
		end
	end
	
  map.root :controller => 'site'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
