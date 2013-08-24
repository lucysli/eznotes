require 'spec_helper'

describe "Notes Pages" do

   subject { page }

   let(:notetaker) { FactoryGirl.create(:notetaker) }
   let(:course) { FactoryGirl.create(:course) }
   before { sign_in notetaker }

   describe "note upload" do
      before do 
         notetaker.register!(course)
         visit course_path(course)
      end

      describe "with invalid information" do
         
         it "should not upload a note" do
            expect { click_button "Upload" }.not_to change(Note, :count)
         end

         describe "error messages" do
            before { click_button "Upload" }
            it { should have_content('error') }
         end
      end

      describe "with valid information" do
         before do
            fill_in 'note_comments',   with: "Lorem ipsum" 
            attach_file 'note_file', Rails.root.join('public', 'assets', 'sample.pdf')
            fill_in 'note_lecture_title', with: "Chem 200"
            fill_in 'note_lecture_date', with: Date.today
         end

         it "should upload a note" do
            expect { click_button "Upload" }.to change(Note, :count).by(1)
         end
      end
   end

   describe "note destruction" do
      before { FactoryGirl.create(:note, user: notetaker, course: course) }

      describe "as correct user" do
         before { visit course_path(course) }

         it "should delete a note" do
            expect { click_link "delete" }.to change(Note, :count).by(-1)
         end
      end
   end
end
