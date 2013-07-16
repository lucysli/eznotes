require 'spec_helper'

describe "User pages" do

	subject { page }

	describe "signup page" do
		before { visit signup_path }

		it { should have_title(full_title('Notetaker Application')) }
	end

	describe 'profile page' do
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }

		it { should have_content(user.name) }
		it { should have_title(user.name) }
	end

	describe "signup" do
		
		before { visit signup_path }

		let(:submit) { "Create my account" }

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
				it { should have_title(user.name) }
				it { should have_success_message('Welcome') }
			end
		end
	end
end
