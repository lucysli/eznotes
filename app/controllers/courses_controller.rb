class CoursesController < ApplicationController
   before_action :signed_in_user 
   before_action :admin_user,     only: [:index, :destroy, :create, :update]
   before_action :registered_user, only: :show

   def show
      if Course.exists?(params[:id])
         @course = Course.find(params[:id])
         @note = current_user.notes.build
         @feed_items = @course.feed.paginate(page: params[:page])
      else
         flash[:error] = "Course does not exist"
         redirect_to root_url
      end
   end

   def index
      @courses = Course.search(params[:search]).paginate(per_page: 10, page: params[:page])
      respond_to do |format|
         format.html 
         format.csv { render text: Course.to_csv }
         format.js
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

   def update
      @course = Course.find(params[:id])
      notetaker = @course.note_taker
      if @course.update_attributes(notetaker_params)
         # Handle a successful update
         if @course.note_taker 
            @course.note_taker.send_assigned_to_course_message(@course)
            @course.registered_users.where("note_taker = ?", false).each do |user|
               if not user.note_taker?
                  user.send_notetaker_assigned(@course)
               end
            end
            message = "Assigned" 
         else 
            notetaker.send_unassigned_from_course_message(@course)
            message = "Unassigned" 
         end
         flash[:success] =  "#{message} #{User.find(params[:user]).name} as the notetaker
         to the #{@course.term} course #{@course.subject_code} #{@course.course_num} #{@course.section}: #{@course.course_title} "
         redirect_to :back
      else
         flash[:error] = "Could not assign #{User.find(params[:user]).name} as the notetaker
         to the  #{@course.term} course #{@course.subject_code} #{@course.course_num} #{@course.section}: #{@course.course_title} "
         redirect_to :back
      end
   end

   def destroy
      @course = Course.find(params[:id])
      @course.destroy
      redirect_to courses_path
   end

   def delete_all_courses
      if Course.delete_all
         flash[:success] = "Deleted all courses"
         redirect_to :back
      else
         flash[:error] = "Could not delete courses"
      end
   end


   private

      def course_params
         params.require(:course).permit(:course_title, :subject_code, :course_num, 
                                        :multi_term_code, :term, :user_id, :crn)
      end

      def notetaker_params
         params.require(:course).permit(:user_id)
      end

      # Before filters

      def admin_user
         redirect_to root_path, notice: "You are not authorized to view this page" unless current_user.admin?
      end

      def registered_user
         redirect_to root_path, notice: "You must be registered for this course to view it" unless current_user.admin? or (Course.exists?(params[:id]) and current_user.registered_with?(Course.find(params[:id])))
      end

end