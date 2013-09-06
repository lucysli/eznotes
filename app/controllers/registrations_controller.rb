class RegistrationsController < ApplicationController
   before_action :signed_in_user

   def new
   end

   def create
      course_string = "#{params[:subject_code]} #{params[:course_num]} #{params[:section]}"
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
         flash[:error] = "Course #{course_string} does not exist. Please verify"
      end
      redirect_to root_url 
   end

   def destroy
      @course = Registration.find(params[:id]).course
      @user = User.find(params[:user])
      if @course then
         if @user.registered_with?(@course)
            flash[:success] = "Unregistered #{@user.name} from the course 
            #{@course.subject_code} 
            #{@course.course_num} 
            #{@course.section} 
            #{@course.course_title}!"
            @user.unregister!(@course)
            # if the user unregistering from the course 
            # is the note taker of the course
            # make sure to unassign the user as the notetaker
            if @course.note_taker?(@user)
               @course.unassign_note_taker
               @course.save
            end
         else
            flash[:error] = "You are not registered with this course!"
         end
      else
         flash[:error] = "Course does not exist"
      end
      redirect_to root_url
   end
end