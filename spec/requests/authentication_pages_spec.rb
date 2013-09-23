require 'spec_helper'

describe "Authentication" do 
   subject { page }

   shared_examples "authentication signin" do 
      before { sign_in user }
      it { should have_link('Profile',       href: user_path(user)) }
      it { should have_link('Settings',      href: edit_user_path(user)) }
      it { should have_link('Sign out',      href: signout_path) }
      it { should_not have_link('Sign in',   href: signin_path) }
      it { should have_title(full_title('')) }

      describe "followed by signout" do
         before { click_link "Sign out" }
         it { should have_link('Sign in') }
      end
   end

   describe "signin page" do
      before { visit signin_path }
      it { should have_title(full_title('Sign in')) }
   end

   describe "signin" do
      before { visit signin_path }

      describe "with invalid information" do
         before do
            click_button "Sign in" 
         end

         it { should have_title('Sign in') }

         describe "after visiting another page" do
            before { click_link "Home" }
            it { should_not have_error_message('') }
         end
      end

      describe "with valid information" do

         describe "as admin user" do         
            it_behaves_like "authentication signin" do
               let(:user) { FactoryGirl.create(:admin) }
               it { should have_link('Users',         href: users_path) }
               it { should have_link('Courses',       href: courses_path) }
            end
         end

         describe "as non admin user" do

            describe "as noteuser" do
               it_should_behave_like "authentication signin" do
                  let(:user) { FactoryGirl.create(:user) }
               end
            end

            describe "as notetaker" do
               it_should_behave_like "authentication signin" do
                  let(:user) { FactoryGirl.create(:notetaker) }
               end
            end
         end
      end
   end

   describe "authorization" do
      
      describe "for non-signed-in users" do
         let(:user) { FactoryGirl.create(:user) }

         it { should_not have_link('Profile',      href: user_path(user)) }
         it { should_not have_link('Settings',     href: edit_user_path(user)) }
         it { should_not have_link('Sign out',     href: signout_path) }

         describe "when attempting to visit a protected page" do
            before do
               visit edit_user_path(user)
               sign_in user
            end

            describe "after signing in" do
               
               it "should render the desired protected page" do
                  expect(page).to have_title(full_title('Edit user'))
               end

               describe "when signing in again" do
                  before do
                     delete signout_path
                     visit signin_path
                     sign_in user
                  end

                  it "should render the default (profile) page" do
                     expect(page).to have_title(full_title(''))
                  end
               end
            end
         end

         describe "in the Users controller" do
            
            describe "visiting the edit page" do
               before { visit edit_user_path(user) }
               it { should have_title(full_title('Sign in')) }
            end

            describe "submitting to the update action" do
               before { patch user_path(user) }
               specify { expect(response).to redirect_to(signin_path) }
            end

            describe "visiting the show page" do
               before { visit user_path(user) }
               it { should have_title(full_title('Sign in')) }
            end

            describe "visiting the user index" do
               before { visit users_path }
               it { should have_title(full_title('Sign in')) }
            end
         end

         describe "in the Notes controller" do
            
            describe "submitting to the create action" do
               before { post notes_path }
               specify { expect(response).to redirect_to(signin_path) }
            end

            describe "submitting to the destroy action" do
               before { delete note_path(FactoryGirl.create(:note)) }
               specify { expect(response).to redirect_to(signin_path) }
            end
         end

         describe "in the Courses controller" do
            let(:realcourse) { FactoryGirl.create(:realcourse) }
            describe "submitting to the create action" do
               before { post courses_path }
               specify { expect(response).to redirect_to(signin_path) }
            end    

            describe "submitting to the destroy action" do
               before { delete course_path(realcourse) }
               specify { expect(response).to redirect_to(signin_path) }
            end   

            describe "submitting to the delete_all action" do
               before { delete delete_all_courses_path }
               specify { expect(response).to redirect_to(signin_path) }
            end   

            describe "submitting to the update action" do
               before { patch course_path(realcourse) }
               specify { expect(response).to redirect_to(signin_path) }
            end 

            describe "visiting the show page" do
               before { visit course_path(realcourse) }
               it { should have_title(full_title('Sign in')) }
            end

            describe "visiting the course index" do
               before { visit courses_path }
               it { should have_title(full_title('Sign in')) }
            end    
         end

         describe "in the Registrations controller" do
            describe "submitting to the create action" do
               before { post registrations_path }
               specify { expect(response).to redirect_to(signin_path) }
            end

            describe "submitting to the destroy action" do
               before { delete registration_path(1) }
               specify { expect(response).to redirect_to(signin_path) }
            end            
         end

         describe "in the course imports controller" do
            describe "submitting to the create action" do
               before { post course_imports_path }
               specify { expect(response).to redirect_to(signin_path) }
            end
            describe "visiting the course imports new" do
               before { visit new_course_import_path }
               it { should have_title(full_title('Sign in')) }
            end
         end

         describe "in the accomodation imports controller" do
            describe "submitting to the create action" do
               before { post accomodations_path }
               specify { expect(response).to redirect_to(signin_path) }
            end
            describe "submitting to the destroy action" do
               before { delete delete_accomodations_path }
               specify { expect(response).to redirect_to(signin_path) }
            end
            describe "visiting the Accomodations#new page" do
               before { visit new_accomodation_path }
               it { should have_title(full_title('Sign in')) }
            end
         end
      end

      describe "as wrong user" do
         let(:user) { FactoryGirl.create(:user) }
         let(:wrong_user) { 
            FactoryGirl.create(:user,  email: "wrong.example@mail.mcgill.ca", 
                                       student_id: "987654321") 
         }
         before { sign_in user, no_capybara: true }

         describe "visiting Users#edit page" do
            before { visit edit_user_path(wrong_user) }
            it { should_not have_title(full_title('Edit user')) }
         end

         describe "submitting a PATCH request to the Users#update action" do
            before { patch user_path(wrong_user) }
            specify { expect(response).to redirect_to(root_path) }
         end

         describe "visiting Users#show page" do
            before { visit user_path(wrong_user) }
            it { should_not have_title(full_title(wrong_user.name)) }
         end
      end

      describe "as non-admin user" do
         let(:user) { FactoryGirl.create(:user) }
         let(:non_admin) { FactoryGirl.create(:user) }

         before { sign_in non_admin, no_capybara: true }

         describe "submitting a DELETE request to the Users#destroy action" do
            before { delete user_path(user) }
            specify { expect(response).to redirect_to(root_path) }
         end

         describe "submitting a CREATE request to the Users#create_admin action" do
            before { put create_admin_path }
            specify { expect(response).to redirect_to(root_path) }
         end

         describe "in the course imports controller" do
            describe "submitting to the create action" do
               before { post course_imports_path }
               specify { expect(response).to redirect_to(root_path) }
            end
         end

         describe "in the accomodation imports controller" do
            describe "submitting to the create action" do
               before { post accomodations_path }
               specify { expect(response).to redirect_to(root_path) }
            end

            describe "submitting to the destroy action" do
               before { delete delete_accomodations_path }
               specify { expect(response).to redirect_to(root_path) }
            end

            describe "visiting Accomodations#index page" do
               before { visit accomodations_path }
               it { should_not have_title(full_title('Accomodations')) }
            end

            describe "visiting the Accomodations#new page" do
               before { visit new_accomodation_path }
               it { should_not have_title(full_title('Accomodation Import')) }
            end
         end
      end

      describe "as signed in users" do
         let(:user) { FactoryGirl.create(:user) }
         let(:realcourse) { FactoryGirl.create(:realcourse) }
         before { sign_in user, no_capybara: true }

         describe "submitting to the new_noteuser action" do
            before { get signup_noteuser_path }
            specify { expect(response).to redirect_to(root_path) }
         end

         describe "submitting to the new_notetaker action" do
            before { get signup_notetaker_path }
            specify { expect(response).to redirect_to(root_path) }
         end

         describe "submitting to the create action" do
            before { post users_path  }
            specify { expect(response).to redirect_to(root_path) }
         end

         describe "submitting a CREATE request to the Users#create_admin action" do
            before { put create_admin_path }
            specify { expect(response).to redirect_to(root_path) }
         end

         describe "visiting Courses#show page for a course you are not registered with" do
            before { visit course_path(realcourse) }
            it { should_not have_title(full_title(realcourse.course_title)) }
         end

         describe "in the password reset controller" do

            describe "submitting to the create action" do
               before { post password_resets_path }
               specify { expect(response).to redirect_to(root_path) }
            end 

            describe "visiting PasswordReset#edit page" do
               before { visit edit_password_reset_path("blah") }
               it { should_not have_title(full_title('Password Reset')) }
            end

            describe "submitting to the update action" do
               before { patch password_reset_path(1) }
               specify { expect(response).to redirect_to(root_path) }
            end  
         end
      end

      describe "as signed in admin" do

         let(:admin) { FactoryGirl.create(:admin) }

         before { sign_in admin, no_capybara: true }

         describe "submitting a DELETE request to the Users#destroy action to delete oneself" do
            before { delete user_path(admin) }
            specify { expect(response).to redirect_to(user_path(admin)) }        
         end
      end

      describe "as signed in notetaker" do
         let(:notetaker) { FactoryGirl.create(:notetaker) }
         let(:realcourse) { FactoryGirl.create(:realcourse) }

         before do
            sign_in notetaker, no_capybara: true 
            notetaker.register!(realcourse)
         end

         describe "submitting a POST request to the Notes#create action to upload notes for a course you are not the notetaker of" do
            before { post notes_path  }
            specify { expect(response).to redirect_to(root_path) } 
         end
      end
   end
end
