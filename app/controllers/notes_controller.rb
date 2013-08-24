class NotesController < ApplicationController
   before_action :signed_in_user, only: [:create, :destroy, :download]
   before_action :correct_user,  only: :destroy
   before_action :note_taker, only: :create

   def create
      @note = current_user.notes.build(note_params)
      if @note.save
         flash[:success] = "Note uploaded!"  
         redirect_to :back
      else
         errors = @note.errors.full_messages.to_sentence.gsub(',',"\n")
         flash[:error] = errors
         @feed_items = [ ]
         redirect_to :back
      end
   end

   def destroy
      @note.destroy
      redirect_to course_path(Course.find(@note.course_id))
   end

   def download
      @note = current_user.notes.find(params[:id])
      send_file @note.file.path, type: @note.file_content_type, disposition: 'inline'
   end

   private

      def note_params
         params.require(:note).permit(:course_id, :file, :comments, :lecture_title, :lecture_date)
      end

      # Before filters

      def correct_user
         @note = current_user.notes.find_by(id: params[:id])
         redirect_to root_url, notice: "Cannot delete a note you did not upload" if @note.nil?
      end

      def note_taker
         redirect_to root_url, notice: "You are not authorized to upload a file." unless current_user.note_taker?
      end
end