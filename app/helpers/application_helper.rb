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
	
	def favorite_state(state)
		case state
			when true:
				"visible"
			when false:
				"hidden"
		end
	end
end
