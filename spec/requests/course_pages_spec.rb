require 'spec_helper'

describe "Course pages" do

   subject { page }

   let(:user) { FactoryGirl.create(:user) }

   before { sign_in user }

   describe "index" do

      describe "as non admin user" do
         before { visit courses_path }
         specify { expect(response).to redirect_to(root_path) }
      end

      describe "as admin user" do
         
         let(:admin) { FactoryGirl.create(:admin) }

         before do
            sign_in admin
            visit courses_path
         end

         #it { should have_title(full_title('All courses')) }
         #it { should have_content('All Courses') }

         describe "pagination" do
            before(:all) { 31.times { FactoryGirl.create(:course) } }
            after(:all) { Course.delete_all }

            it { should have_selector('div.pagination') }

            it "should list each course" do
               Course.paginate(page: 1).each do |course|
                  expect(page).to have_selector('dt', text: course.subject_code)
                  expect(page).to have_selector('dt', text: course.course_num)
                  expect(page).to have_selector('dt', text: course.section)
                  expect(page).to have_selector('dd', text: course.course_title)
               end
            end
         end

         describe "delete links" do
            before { FactoryGirl.create(:course, term: "fall") }

            it { should have_link('delete', href: course_path(Course.first)) }

            it "should be able to delete a course" do
               expect { click_link('delete') }.to change(Course, :count).by(-1)
            end
         end
      end
   end

   describe "show page" do

      describe "as signed in user" do
         let(:course) { FactoryGirl.create(:course) }

         before { visit course_path(course) }

         describe "viewing an unregistered course" do
            
            it { should 
               have_error_message("You are not registered for this course") }
            specify { expect(response).to redirect_to(root_path) }
         end

         describe "viewing a registered course" do
            before do 
               31.times { FactoryGirl.create(:note, user: user, course: course) }
               user.register!(course) 
            end

            it { should have_title(full_title(course.course_title)) }

            it "should render the course notes feed" do
               course.feed.paginate(page: 1).each do |item|
                  expect(page).to have_link(item.user.name, href: user_path(item.user))
                  expect(page).to have_selector("li##{item.id}", text: item.lecture_title)
                  expect(page).to have_selector("li##{item.id}", text: item.lecture_date)
                  expect(page).to have_selector("li##{item.id}", text: item.comments)
               end              
            end

            describe "sidebar" do
               it { should have_content(course.term) }
               it { should have_content(course.subject_code) }
               it { should have_content(course.course_num) }
               it { should have_content(course.section) }
               it { should have_content(course.course_title) }

               it { should have_content("31 notes uploaded") }

               it { should have_content("1 student registered") }
            end
         end
      end
   end
end