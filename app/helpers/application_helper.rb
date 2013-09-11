module ApplicationHelper

	# Returns the full title on a per-page basis.
	def full_title(page_title)
		base_title = "McGill EZ Notes"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

   def bootstrap_class_for flash_type
    case flash_type
      when :success
        "alert-success"
      else
        flash_type.to_s
    end
  end
end
