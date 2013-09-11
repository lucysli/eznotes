class PasswordResetsController < ApplicationController
   before_action :not_signed_in_user

   def new    
   end

   def create
      user = User.find_by_email(params[:email])
      if user
         user.send_password_reset
         flash[:success] = "Email sent with password reset instructions."
         redirect_to :root
      else
         flash.now[:error] = "Email not sent invalid email inputted."
         render 'new'
      end
   end

   def edit
     @user = User.find_by_password_reset_token!(params[:id])
   end

   def update
      @user = User.find_by_password_reset_token!(params[:id])
      if @user.password_reset_sent_at < 2.hours.ago
         redirect_to new_password_reset_path, :alert => "Password reset has expired."
      elsif @user.update_attributes(update_params)
         redirect_to root_url, :notice => "Password has been reset."
      else
         render :edit
      end
   end

   private

      def update_params
         params.require(:user).permit(:password, :password_confirmation)
      end

      # before filters

      def not_signed_in_user
         if signed_in?
            redirect_to root_path, notice: "You are not authorized to access this page."
         end
      end
end
