class CoursesController < ApplicationController
   before_action :signed_in_user, only: [:show, :index, :create, :destroy]
   before_action :admin_user,     only: [:index]

   def show
      @course = Course.find(params[:id])
      @note = current_user.notes.build
      @feed_items = @course.feed.paginate(page: params[:page])
   end

   def index
      @term = params[:term]
      if @term == "Fall"
         @fall_courses = Course.fall_courses.paginate(page: params[:fall_page])
      elsif @term == "Winter"
         @winter_courses = Course.winter_courses.paginate(page: params[:winter_page])
      elsif @term == "Summer"
         @summer_courses = Course.summer_courses.paginate(page: params[:summer_page])
      else
         @courses = Course.all.paginate(page: params[:all_page])
      end   
   end
   
   def create
      @course = Course.new(course_params)
      if @course.save
         flash[:success] = "Course Created!"
         redirect_to root_url
      else
         @fall_course_feed_items = current_user.fall_course_feed.paginate(page: params[:page])
         @winter_course_feed_items = current_user.winter_course_feed.paginate(page: params[:page])
         @summer_course_feed_items = current_user.summer_course_feed.paginate(page: params[:page])
         render 'static_pages/home'
      end
   end

   def destroy
      @course = Course.find(params[:id])
      @course.destroy
      redirect_to courses_path
   end


   private

      def course_params
         params.require(:course).permit(:course_title, :subject_code, :course_num, 
                                        :multi_term_code, :term)
      end

      # Before filters

      def admin_user
         redirect_to root_path, notice: "You are not authorized to view this page" unless current_user.admin?
      end

end