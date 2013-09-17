require 'spec_helper'

describe "CourseImportPages" do
   describe "course import" do

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
            attach_file 'courses', Rails.root.join('app', 'assets', 'files', 'Fall', 'all.csv')
         end

         it "should import courses" do
            expect { click_button "Import" }.to change(Course, :count).by(1072)
         end
      end
   end
end
