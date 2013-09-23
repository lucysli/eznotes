class AccomodationsController < ApplicationController
   before_action :signed_in_user 
   before_action :admin_user 

   def index
      @accomodations = Accomodation.all
   end

   def new
      @accomodation = Accomodation.new
   end

   def create
      @accomodation = Accomodation.new(accomodation_params)
      if @accomodation.save
         flash[:success] = "Accomodation added"
         redirect_to accomodations_path
      else
         render 'new'
      end
   end

   def import
      file = params[:file]
      if file.nil?
         flash.now[:error] = "Empty file passed"
         render :new
      elsif File.extname(file.original_filename) != ".csv" and File.extname(file.original_filename) != ".xlsx"
         flash.now[:error] = "Incorrect file format #{File.extname(file.original_filename)}: only .csv or .xlsx files allowed"
         render 'new'
      else
         Accomodation.import(file)
         flash[:success] = "Successfully imported accomodations"
         redirect_to accomodations_path
      end
   end

   def delete_accommodations
      if Accomodation.delete_all
         flash[:success] = "Deleted all Accomodations"
         redirect_to :back
      else
         flash[:error] = "Could not delete accomodations"
      end
   end

   private

      def accomodation_params
         params.require(:accomodation).permit(:student_id, :note_taking)
      end

      # Before filters

      def admin_user
         redirect_to root_path, notice: "You are not authorized to view this page" unless current_user.admin?
      end
end
