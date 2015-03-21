module ApplicationHelper
	def full_title(page_title="")
		base_title = "Ruby on Rails Tutoriel Sample App"
		if page_title.empty?
			base_title
		else
			"#{page_title} | #{base_title} #{page_title} Page"
		end
	end
end
