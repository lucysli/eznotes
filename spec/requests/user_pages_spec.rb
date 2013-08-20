require 'spec_helper'

describe "User pages" do

	subject { page }

	describe "index" do
		let(:user) { FactoryGirl.create(:user) }
		before(:each) do
			sign_in user
			visit users_path
		end

		it { should have_title(full_title('All users')) }
		it { should have_content('All users') }

		describe "pagination" do
			before(:all) { 30.times { FactoryGirl.create(:user) } }
			after(:all) { User.delete_all }

			it { should have_selector('div.pagination') }

			it "should list each user" do
				User.paginate(page: 1).each do |user|
					expect(page).to have_selector('li', text: user.name)
				end
			end
		end

		describe "delete links" do
			
			it { should_not have_link('delete') }

			describe "as an admin user" do
				let(:admin) { FactoryGirl.create(:admin) }
				before do
					sign_in admin
					visit users_path
				end

				it { should have_link('delete', href: user_path(User.first)) }
				it "should be able to delete another user" do
					expect { click_link('delete') }.to change(User, :count).by(-1)
				end
				it { should_not have_link('delete', href: user_path(admin)) }
			end
		end
	end

	describe "signup page" do
		before { visit signup_path }

		it { should have_title(full_title('Notetaker Application')) }
	end

	describe 'profile page' do
		let(:user) { FactoryGirl.create(:user) }
		let(:course_m1) { FactoryGirl.create(:course) }
		let(:course_m2) { FactoryGirl.create(:course) }
		let!(:m1) { FactoryGirl.create(:note, user: user, course: course_m1, comments: "Foo") }
    	let!(:m2) { FactoryGirl.create(:note, user: user, course: course_m2, comments: "Bar") }
		before do
			sign_in user
			visit user_path(user) 
		end

		it { should have_content(full_title(user.name)) }
		it { should have_title(full_title(user.name)) }

		describe "notes" do
			it { should have_content(course_m1.subject_code + " " + course_m1.course_num) }
			it { should have_content(m1.lecture_title) }
			it { should have_content(m1.lecture_date) }
      	it { should have_content(m1.comments) }

			it { should have_content(course_m2.subject_code + " " + course_m2.course_num) }
      	it { should have_content(m2.lecture_title) }
			it { should have_content(m2.lecture_date) }
			it { should have_content(m2.comments) }

      	it { should have_content(user.notes.count) }
      end
	end

	describe "signup" do
		
		before { visit signup_path }

		let(:submit) { "Next" }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end

			describe "after submission" do
				before { click_button submit }

				it { should have_title('Notetaker Application') }
				it { should have_content('error') }
			end
		end

		describe "with valid information" do
			before do
				fill_in "Name",			with: "Example User"
				fill_in "Email",		with: "example.user@mail.mcgill.ca"
				fill_in "Student ID",	with: "260012345"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end

			describe "after saving the user" do
				before { click_button submit }
				let(:user) { User.find_by(email: 'example.user@mail.mcgill.ca') }

				it { should have_link('Sign out') }
				it { should have_title(full_title('')) }
				it { should have_success_message('Welcome') }
			end
		end
	end

	describe "edit" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			visit edit_user_path(user) 
		end

		describe "page" do
			it { should have_content("Update your profile") }
			it { should have_title(full_title("Edit user")) }
		end

		describe "with invalid information" do
			before do
				# we need to do this because by default the name field
				# is filled with the old name so we set it to empty
				# so that the error name cannot be blank shows up
				fill_in "Name",	with: ''
				click_button "Save changes" 
			end

			it { should have_content('error') }
		end

		describe "with valid information" do
			let(:new_name) { "New Name" }
			before do
			  fill_in "Name",	with: new_name
			  click_button "Save changes"
			end

			it { should have_title(full_title('')) }
			it { should have_success_message('Profile updated') }
			it { should have_link('Sign out', href: signout_path) }
			specify { expect(user.reload.name).to eq new_name }
		end

		describe "forbidden attributes" do
			let(:params) do
				{ user: { admin: true } }
			end
			before { patch user_path(user), params }
			specify { expect(user.reload).not_to be_admin }
		end
	end
end
