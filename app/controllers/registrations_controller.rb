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
            @registrations << { "id" => course.id,
                                "name" => "#{course.term.upcase} | #{course.subject_code}-#{course.course_num}-#{course.section}: #{course.course_title}",
                                "term" => "#{course.term.upcase}",
                                "subject_code" => "#{course.subject_code}", 
                                "course_num" => "#{course.course_num}",
                                "section" => "#{course.section}",
                                "course_title" => "#{course.course_title}" }
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
      success_messages = ""

      if params[:user][:user]
        @user = User.find(params[:user][:user])
      else
        @user = current_user
      end

      courses.each do |course|
        @course = Course.find(course)     
        if @course then
          course_string = "#{@course.subject_code}-#{@course.course_num}-#{@course.section} -> #{@course.course_title}"
          if @user.registered_with?(@course)
            error_messages += "<i class='icon-exclamation icon-large'></i> <strong>#{@user.name}</strong> is already registered with the course: <em class>#{course_string}</em> in the <em>#{@course.term.upcase}</em> term<br>"
          else
            @user.registrations.build(course_id: @course.id)
            if @user.register!(@course)
              success_messages += "<i class='icon-ok icon-large'></i> Registered <strong>#{@user.name}</strong> for the course: <em class>#{course_string}</em> in the <em>#{@course.term.upcase}</em> term<br>"
              if @course.note_taker and not @user.note_taker? and not @user.admin?
                @user.send_notetaker_assigned(@course)
              end
            else
              error_messages += "<strong class='icon-exclamation icon-large'> #{@user.name}</strong> could not register for the course: <em class>#{course_string}</em> in the <em>#{@course.term.upcase}</em> term<br>"
            end 
          end
        end
      end

      if error_messages != ""
        flash[:error] = error_messages.html_safe
      end

      if success_messages != ""
        flash[:success] = success_messages.html_safe
      end

      redirect_to root_path
   end

   def destroy
      @course = Registration.find(params[:id]).course
      @user = User.find(params[:user])
      if @course then
         if @user.registered_with?(@course)
            flash[:success] = "<i class='icon-ok icon-large'></i> Unregistered <strong> #{@user.name} </strong> from the course <em>#{@course.subject_code}-#{@course.course_num}-#{@course.section} -> #{@course.course_title}</em> in the <em>#{@course.term.upcase}</em> term.".html_safe
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
            flash[:error] = "<i class='icon-exclamation icon-large'></i> <strong>#{@user.name} </strong> is not registered with this course".html_safe
         end
      else
         flash[:error] = "<i class='icon-exclamation icon-large'></i> Course does not exist".html_safe
      end
      redirect_to root_url
   end
end