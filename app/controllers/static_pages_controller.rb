class StaticPagesController < ApplicationController

	def home	
		if signed_in?
			@feed_items = current_user.notes_feed.paginate(page: params[:page])
			@fall_course_feed_items = current_user.fall_course_feed.paginate(page: params[:page])
			@winter_course_feed_items = current_user.winter_course_feed.paginate(page: params[:page])
			@summer_course_feed_items = current_user.summer_course_feed.paginate(page: params[:page])
			@registered_courses = Course.all.where("id IN (?)", Registration.distinct.pluck(:course_id))
		end
	end

	def contact	
	end

	def help
	end

	def about
	end

	def signup
	end

	def signup2
	end

	def signup3
	end

	def signup4
	end

	def notetaker
	end
	
	def notetaker2
	end
	
	def upload
	end

end
