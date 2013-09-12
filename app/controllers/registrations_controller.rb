class RegistrationsController < ApplicationController
   before_action :signed_in_user

   def index
      if params[:q]
         query = params[:q].split
         @courses = Course.where("subject_code ILIKE ? or
                                  course_num ILIKE ? or
                                  course_title ILIKE ? or
                                  (subject_code ILIKE ? and
                                  course_num ILIKE ?)", 
                                  "%#{params[:q]}%",
                                  "%#{params[:q]}%",
                                  "%#{params[:q]}%",
                                   "%#{query[0]}%",
                                   "%#{query[1]}%")
         @registrations = []
         @courses.each do |course|
            @registrations << { "id" => course.id, "name" => "#{course.term.upcase} | #{course.subject_code} #{course.course_num} #{course.section}: #{course.course_title}" }
         end
      end

      respond_to do |format|
         format.html { redirect_to root_path }
         format.json { render :json => @registrations }
      end 
   end

   def create
      
      courses = params[:user][:course_tokens].split(',')

      error_messages = ""

      courses.each do |course|
        @course = Course.find(course)     
        if @course then
          course_string = "#{@course.term.upcase} | #{@course.subject_code} #{@course.course_num} #{@course.section}: #{@course.course_title}"
          if current_user.registered_with?(@course)
            flash[:error] = "Already registered with course: #{course_string}!"
            #current_user.errors.add :base, "Already registered with course: #{course_string}!"
          else
            current_user.registrations.build(course_id: @course.id)
            if current_user.register!(@course)
              flash[:success] = "Registered for course: #{course_string}!"
            else
              flash[:error] = "Could not register for course: #{course_string}!"
              #current_user.errors.add :base, "Could not register for course: #{course_string}!"
            end 
          end
        end
      end

        redirect_to root_path
   end

   def destroy
      @course = Registration.find(params[:id]).course
      @user = User.find(params[:user])
      if @course then
         if @user.registered_with?(@course)
            flash[:success] = "Unregistered #{@user.name} from the course #{@course.term.upcase} | #{@course.subject_code} #{@course.course_num} #{@course.section} #{@course.course_title}!"
            @user.unregister!(@course)
            # if the user unregistering from the course 
            # is the note taker of the course
            # make sure to unassign the user as the notetaker
            if @course.note_taker?(@user)
              @course.unassign_note_taker
              @user.send_unassigned_from_course_message(@course)
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