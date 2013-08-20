class RegistrationsController < ApplicationController
   before_action :signed_in_user

   def new
   end

   def create
      @course = Course.find_by   subject_code: params[:subject_code],
                                 course_num: params[:course_num],
                                 term: params[:term],
                                 section: params[:section]                                             
      if @course then
         if current_user.registered_with?(@course)
            flash[:error] = "Already registered with this course!"
         else
            current_user.registrations.build(course_id: @course.id)
            if current_user.register!(@course)
               flash[:success] = "Registered for course!"
            else
               flash[:error] = "Could not register for course!"
            end 
         end
      else
         flash[:error] = "Course does not exist"
      end
      redirect_to root_url 
   end

   def destroy
      @course = Registration.find(params[:id]).course
      if @course then
         if current_user.registered_with?(@course)
            flash[:success] = "Unregistered for course 
            #{@course.subject_code} 
            #{@course.course_num} 
            #{@course.section} 
            #{@course.course_title}!"
            current_user.unregister!(@course)
         else
            flash[:error] = "You are not registered with this course!"
         end
      else
         flash[:error] = "Course does not exist"
      end
      redirect_to root_url
   end
end