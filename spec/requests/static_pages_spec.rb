require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_title(full_title(page_title)) }
  end

  shared_examples "course feed" do |term|
    it "should render the user's registered #{term} courses" do
      course_feed.each do |item|
        expect(page).to have_selector("div##{item.id}", text: item.subject_code)
        expect(page).to have_selector("div##{item.id}", text: item.course_num)
        expect(page).to have_selector("div##{item.id}", text: item.section)
        expect(page).to have_selector("div##{item.id}", text: item.course_title)
      end
    end
  end

	describe "Home page" do

    before { visit root_path }

    let(:page_title) { '' }

    it_should_behave_like "all static pages"

    describe "for signed-in users" do

      describe "for admin users" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit root_path
        end

        describe "the register for courses form" do
          it "should not have the add course form" do
            expect(page).not_to have_selector("form#add_course")
          end
        end
      end
      
      describe "for non admin users" do
        let(:user) { FactoryGirl.create(:user) }

        describe "The course feed" do
          
          before(:each) do
            10.times { user.register!(FactoryGirl.create(:course)) }
            sign_in user
            visit root_path 
          end

          after(:each) do
            user.fall_course_feed.delete_all
            user.winter_course_feed.delete_all
            user.summer_course_feed.delete_all
          end

          describe "the user's registered fall courses" do
            it_behaves_like "course feed", "fall" do
              let(:course_feed) { user.fall_course_feed }
            end
          end

          describe "the user's registered winter courses" do
            it_behaves_like "course feed", "winter" do
              let(:course_feed) { user.winter_course_feed }
            end
          end

          describe "the user's registered summer courses" do
            it_behaves_like "course feed", "summer" do
              let(:course_feed) { user.summer_course_feed }
            end
          end

          describe "the side bar" do
            it "should have correct course count and pluralize" do
              expect(page).to have_content("Registered for 10 courses")
            end
            it "should have not have course notetaking for count" do
              expect(page).not_to have_content("Notetaking for 2 courses")
            end

            describe "for notetakers" do
              let(:notetaker) { FactoryGirl.create(:notetaker) }
              let(:course) { FactoryGirl.create(:course) }
              let(:course2) { FactoryGirl.create(:course) }
              before do
                sign_in notetaker
                visit root_path
                notetaker.register!(course)
                notetaker.register!(course2)
                course.assign_notetaker!(notetaker)
                course2.assign_notetaker!(notetaker)
              end
              it "should have correct course notetaking for count and pluralize" do
                expect(page).to have_content("Notetaking for 2 courses")
              end
            end
          end
        end

        describe "register/unregister buttons" do
          let(:course) { FactoryGirl.create(:course) }

          before do
            sign_in user
            visit root_path 
          end

          describe "registering for a course" do

            describe "with invalid information" do
              before { click_button "Register" }

              it { should have_error_message('Course does not exist') }

            end

            describe "with valid information" do
              
              before do
                select course.subject_code, from: "subject_code"
                select course.course_num, from: "course_num"
                select course.section, from: "section"
                select course.term, from: "term"
              end

              it "should increment the users registered course count" do
                expect do
                  click_button "Register"
                end.to change(user.registered_courses, :count).by(1)
              end

              it "should increment the courses registered user count" do
                expect do
                  click_button "Register"
                end.to change(course.registered_users, :count).by(1)
              end

              describe "registering for a course already registered for" do
                
              end
            end
          end

          describe "unregistering a course" do
            let(:course) { FactoryGirl.create(:course) }

            before do
              user.register!(course)
            end

            it "should decrement the users registered course count" do
              expect do
                all(:xpath, "//input[@value='Unregister']")[-1].click
              end.to change(user.registered_courses, :count).by(-1)
            end

            it "should decrement the course's registered user count" do
              expect do
                all(:xpath, "//input[@value='Unregister']")[-1].click
              end.to change(course.registered_users, :count).by(-1)
            end 
          end
        end
      end
    end
	end

  describe "Help page" do
    before { visit help_path }
    let(:page_title) { 'Help' }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    let(:page_title) { 'About Us' }

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do

    before { visit contact_path }
    let(:page_title) { 'Contact' }

    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About Us'))
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
    click_link "Home"
    expect(page).to have_title(full_title(''))
    click_link "Apply to be a notetaker"
    expect(page).to have_title(full_title('Notetaker Application'))
    click_link "McGill EZ Notes"
    expect(page).to have_title(full_title(''))
  end
end
