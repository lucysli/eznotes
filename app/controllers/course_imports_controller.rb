class CourseImportsController < ApplicationController
   before_action :signed_in_user 
   before_action :admin_user 
   
   def new
      @course_import = CourseImport.new
   end

   def create
      @course_import = CourseImport.new(params[:course_import])
      if not @course_import.valid?
         render :new
      elsif @course_import.save
         flash[:success] = "Successfully imported courses"
         redirect_to courses_path
      else
         render :new
      end
   end

   private

      def course_import_params
         params.require(:course_import).permit(:file, :term)
      end

      # Before filters

      def admin_user
         redirect_to root_path, notice: "You are not authorized to view this page" unless current_user.admin?
      end
end
