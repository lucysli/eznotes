class CourseImportsController < ApplicationController
   def new
      @course_import = CourseImport.new
   end

   def create
      @course_import = CourseImport.new(params[:course_import])
      if @course_import.save
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
end
