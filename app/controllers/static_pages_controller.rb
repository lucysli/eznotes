class StaticPagesController < ApplicationController

	def home	
		if signed_in?
			@note = current_user.notes.build
			@feed_items = current_user.feed.paginate(page: params[:page])
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
