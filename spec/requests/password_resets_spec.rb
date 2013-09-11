require 'spec_helper'

describe "PasswordResets" do

   subject { page }
   let(:user) { FactoryGirl.create(:user) }

   describe "Emailing user when requesting password reset" do

      before do 
         visit signin_path 
         click_link "password"
         fill_in "Email", with: user.email
         click_button "Reset Password"
      end

      it { current_path.should eq(root_path) }

      it { should have_content("Email sent") }

      it "should include the email of the user" do
         last_email.to.should include(user.email)
      end
   end
   describe "invalid user email when requesting password reset" do
      before do 
         visit signin_path 
         click_link "password"
         fill_in "Email", with: "madeup.user@mail.mcgill.ca"
         click_button "Reset Password"
      end

      it { current_path.should eq(password_resets_path) }

      it { should have_content("Email not sent invalid email inputted") }

      it "should not include the email of the user" do
         last_email.should be_nil
      end
   end

   describe "updating the user password" do
      let(:resetting_user) { FactoryGirl.create(:user, password_reset_token: "something", password_reset_sent_at: 1.hour.ago)  }
      before do      
         visit edit_password_reset_path(resetting_user.password_reset_token)
         fill_in "Password", with: "password"
      end

      describe "when confirmation does not match" do
         before do
           click_button "Update Password"
         end

         it { should have_error_message('The form contains 2 errors.') }
         it { should have_content('Password confirmation doesn\'t match Password') }

      end

      describe "when confirmation matches" do
         before do
            fill_in "Password confirmation", with: "password"
            click_button "Update Password"
         end

         it { should have_notice_message('Password has been reset') }
         it { should have_content("Password has been reset") }
      end
   end

   describe "password token expiration" do
      let(:expiring_user) { FactoryGirl.create(:user, password_reset_token: "something", password_reset_sent_at: 5.hour.ago)  }
      before do      
         visit edit_password_reset_path(expiring_user.password_reset_token)
         fill_in "Password", with: "password"
         fill_in "Password confirmation", with: "password"
         click_button "Update Password"
      end

      it { should have_content("Password reset has expired") }

      it "raises record not found when password token is invalid" do
         lambda {
            visit edit_password_reset_path("invalid")
         }.should raise_exception(ActiveRecord::RecordNotFound)
      end
   end
end
