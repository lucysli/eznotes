class NotesController < ApplicationController
   before_action :signed_in_user, only: [:create, :destroy]
   before_action :login_required,  only: [:download]
   before_action :correct_user,  only: :destroy

   def create
      @note = current_user.notes.build(note_params)
      if @note.save
         flash[:success] = "Note uploaded!"
         redirect_to root_url
      else
         @feed_items = [ ]
         render 'static_pages/home'
      end
   end

   def destroy
      @note.destroy
      redirect_to root_url
   end

   def download
      @note = current_user.notes.find(params[:id])
      send_file @note.file.path, type: @note.file_content_type, disposition: 'inline'
   end

   private

      def note_params
         params.require(:note).permit(:file, :comments, :lecture_title, :lecture_date)
      end

      def downloadable?(user)
         current_user?(user) && signed_in?
      end

      # Before filters

      def login_required
         redirect_to root_path, notice: "You are not authorized to download this file." unless downloadable?(current_user)
      end

      def correct_user
         @note = current_user.notes.find_by(id: params[:id])
         redirect_to root_url if @note.nil?
      end
end