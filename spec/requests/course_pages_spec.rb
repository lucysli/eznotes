require 'spec_helper'

describe "Course pages" do

   subject { page }

   let(:user) { FactoryGirl.create(:user) }

   before { sign_in user }

   describe "index" do

      describe "as non admin user" do
         before { visit courses_path }
         specify { expect(page).to have_title(full_title('')) }
      end

      describe "as admin user" do
         
         let(:admin) { FactoryGirl.create(:admin) }

         before do
            sign_in admin
            visit courses_path
         end

         it { should have_title(full_title('Courses')) }
         it { should have_content('Courses') }

         describe "pagination" do
            before(:all) { 31.times { FactoryGirl.create(:course) } }
            after(:all) { Course.delete_all }

            it { should have_selector('div.pagination') }

            it "should list each course" do
               Course.paginate(page: 1).each do |course|
                  expect(page).to have_selector("dt##{course.id}", text: "#{course.subject_code} #{course.course_num} #{course.section} ( #{course.term.upcase} )")
                  expect(page).to have_selector('dd', text: course.course_title)
               end
            end
         end

         describe "delete links" do
            let(:course) { FactoryGirl.create(:course) }

            it { should have_link('delete', href: course_path(course)) }

            it "should be able to delete a course" do
               expect { click_link('delete') }.to change(Course, :count).by(-1)
            end
         end
      end
   end

   describe "show page" do

      describe "as signed in user" do
         let(:realcourse) { FactoryGirl.create(:realcourse) }

         describe "viewing an unregistered course" do
            before { visit course_path(realcourse) }
            it { should 
               have_notice_message("You must be registered for this course to view it") }
            specify { expect(page).to have_title(full_title('')) }
         end

         describe "viewing a registered course as a note user" do
            
            before do 
               user.register!(realcourse)
               
               visit course_path(realcourse) 
            end

            it { should have_title(full_title(realcourse.course_title)) }

            describe "sidebar" do
               it { should have_content("#{realcourse.subject_code} #{realcourse.course_num} #{realcourse.section} ( #{realcourse.term.upcase} )", href: course_path(realcourse)) }
               it { should have_content(realcourse.course_title) }

               it { should have_content("1 noteuser registered") }
               it { should have_content("0 notetakers registered") }
               it { should have_content("0 notetakers assigned") }
               it { should have_content("0 notes uploaded") }
            end

            it "should not have the note upload form" do
               expect(page).not_to have_selector("form#new_note")
            end

            describe "with a note taker assigned" do
               let(:notetaker) { FactoryGirl.create(:notetaker) }
               before do 
                  notetaker.register!(realcourse)
                  realcourse.note_taker = notetaker
                  realcourse.save
                  31.times { FactoryGirl.create(:note, user: notetaker, course: realcourse) }
               end
               it "should render the course notes feed" do
                  realcourse.feed.paginate(page: 1).each do |item|
                     expect(page).to have_selector("li##{item.id}", text: item.lecture_title)
                     expect(page).to have_selector("li##{item.id}", text: item.lecture_date)
                     expect(page).to have_selector("li##{item.id}", text: item.comments)
                  end              
               end

               describe "sidebar" do
                  it { should have_content "1 notetaker assigned" }
                  it { should have_content("31 notes uploaded") }
               end
            end
         end
         describe "viewing a registered course as a note taker" do
            let(:notetaker) { FactoryGirl.create(:notetaker) }
            before do 
               sign_in notetaker
               notetaker.register!(realcourse)
               visit course_path(realcourse)
            end
            describe "when not assigned as note taker of the course" do
               it "should not have the note upload form" do
                  expect(page).not_to have_selector("form#new_note")
               end
            end
            describe "when assigned as note taker of the course" do
               before do
                 realcourse.note_taker = notetaker
                 realcourse.save
               end
               it "should not have the note upload form" do
                  expect(page).not_to have_selector("form#new_note")
               end
            end
         end
      end
   end
end