require 'spec_helper'

describe "CourseImportPages" do

   subject { page }
   let(:admin) { FactoryGirl.create(:admin) }
   describe "course import" do

      before do
         sign_in admin
         visit new_course_import_path 
      end

      it { should have_title(full_title('Course Import')) }

      it { should have_content("Course Import") }

      describe "with invalid information" do

         it "should not import courses" do
            expect { click_button "Import" }.not_to change(Course, :count)
         end

         describe "error messages" do
            before { click_button "Import" }
            it { should have_content('error') }
         end
      end

      describe "with valid information" do
         before do
            attach_file 'file', Rails.root.join('app', 'assets', 'files', 'Fall', 'all.csv')
         end

         it "should import courses" do
            expect { click_button "Import" }.to change(Course, :count).by(7200)
         end
      end
   end
end
