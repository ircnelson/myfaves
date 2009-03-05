# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def page_link_or_span(text, page = nil, options = {})
		page ||= "/"
	  if page && !current_page?(page)
      link_to text, url_for(page), options
		else
		  content_tag :span, text, options
    end
	end

	def logged_in(&block)
		concat content_tag(:div, capture(&block)) if logged_in?
	end
	
	def favorite_link_to(object, html_options = {})
		name = (object.name.blank? ? truncate(object.url, 30) : object.name).gsub("www\.", '').gsub("http://", '')
		url ||= object.url
		html_options[:title] ||= object.description
		link_to(name, url, html_options)
	end
	
	def favorite_link(object, name = nil, options = {})
		case options[:class]
			when 'favorite'
				favorite_count = object.favorites.count unless object.blank?
				favorite_pluralize = pluralize(favorite_count, "Favorite") unless favorite_count.blank?
				name ||= favorite_pluralize
				link_to(name, section_path(object), :class => 'favorite', :title => name)
			when 'new_favorite'
				name ||= 'Add Favorite'
				link_to(name, new_section_favorite_path(object), :class => 'new_favorite', :title => name)
			when 'edit'
				name ||= 'Edit'
				link_to(name, edit_section_path(object), :class => 'edit', :title => name)
			when 'delete'
				name ||= 'Delete'
				link_to(name, section_path(object), :class => 'delete', :title => name, :confirm => 'Are you sure?', :method => :delete)
		end
	end
	
	def favorite_state(state)
		case state
			when true:
				"visible"
			when false:
				"hidden"
		end
	end
	
	def bubbles_display(collection, parent_id = nil, &block)
		return nil if collection.blank?
		li = ''
		collection.collect do |item|
			next if item.parent_id != parent_id
			li += render(:partial => "sections/bubble", :locals => { :section => item })
			li += bubbles_display(item.all_children, item.id) unless item.children.blank?
		end
		li
	end
	
end
