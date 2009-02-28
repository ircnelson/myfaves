# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def page_link_or_span(text, page = nil, options = {})
		page ||= "/"
	  if page && !current_page?(page)
      page_link page, text, options
		else
		  page_span text, options
    end
	end

	def page_link(page, text, options = {})
		link_to text, url_for(page), options
	end

	def page_span(text, options = {})
		content_tag :span, text, options
	end
	
	def logged_in(&block)
		concat content_tag(:div, capture(&block)) if logged_in?
	end
	
	def favorite_link_to(object)
		name = (object.name.blank? ? truncate(object.url, 30) : object.name)
		url ||= object.url
		link_to(name, url)
	end
	
	def favorite_link(object, name = nil, options = {})
		case options[:class]
			when 'favorite'
				favorite_count = object.favorites.count unless object.blank?
				favorite_pluralize = pluralize(favorite_count, "Favorite") unless favorite_count.blank?
				name ||= favorite_pluralize
				link_to(name, section_favorites_path(object), :class => 'favorite', :title => name)
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
			li += render(:partial => "section", :locals => { :section => item })
			li += bubbles_display(item.all_children, item.id) unless item.children.blank?
		end
		li
	end
	
end
