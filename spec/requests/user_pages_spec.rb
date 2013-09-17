require 'spec_helper'

describe "User pages" do

	subject { page }

	describe "index" do
		describe "as note user" do
			let(:user) { FactoryGirl.create(:user) }
			before do
			  sign_in user
			  visit users_path
			end
			after { User.delete_all }

			it { should_not have_link('delete') }

			it { should_not have_title(full_title('All users')) }
			it { should_not have_content('All users') }
			it { should have_notice_message('You are not authorized to access this page.') }
		end

		describe "as note taker" do
			let(:notetaker) { FactoryGirl.create(:notetaker) }
			before do
			  sign_in notetaker
			  visit users_path
			end

			it { should_not have_link('delete') }

			it { should_not have_title(full_title('All users')) }
			it { should_not have_content('All users') }
			it { should have_notice_message('You are not authorized to access this page.') }
		end
		describe "as an admin user" do
			let(:admin) { FactoryGirl.create(:admin) }
			
			before(:each) do
				sign_in admin
				visit users_path
			end

			it { should have_title(full_title('All users')) }
			it { should have_content('All users') }

			describe "pagination" do
				before do
					6.times { FactoryGirl.create(:user) } 
				end
				after(:all) { User.delete_all }


				it "should list each user" do
					User.all.each do |user|
						expect(page).to have_selector('li', text: "#{user.student_id}")
					end
				end

				describe "delete links" do
					it { should have_link("delete", href: user_path(User.first)) }
					it "should be able to delete another user" do
						expect do
							click_link("delete", match: :first)
						end.to change(User, :count).by(-1)
					end
					it { should_not have_link("delete", href: user_path(admin)) }
				end

				describe "approving notetakers links" do

					it { should have_link("Approve", href: user_path(notetaker)) }

					describe "should be able to approve a notetaker" do
						before do
							click_link("Approve", match: :first)
						end

						specify { expect(notetaker.reload).to be_approved }

						it { should have_success_message('Profile updated') }
						it { should_not have_link("Approve", href: user_path(notetaker)) }
						it { should have_link("Unapprove", href: user_path(notetaker)) }
					end

					it { should_not have_link("Approve", href: user_path(admin)) }
				end
			end

			describe "add admin" do
				let(:submit) { "Create Account" }
				describe "with invalid information" do
					it "should not create an admin user" do
						expect { click_button submit }.not_to change(User, :count)
					end
				end

				describe "with valid information" do
					before do
					  fill_in "Name",				with: "Admin User"
					  fill_in "Email",			with: "admin.user@mcgill.ca"
					  fill_in "Student ID",		with: "021231230"
					  fill_in "Password",		with: "adminuser"
					  fill_in "Confirmation",	with: "adminuser"
					end

					it "should create an admin" do
						expect { click_button submit }.to change(User, :count).by(1)
					end

					describe "after saving the admin" do
						before { click_button submit }
						let(:admin) { User.find_by(email: 'admin.user@mcgill.ca') }

						it { should have_title(full_title('All users')) }
						it { should have_success_message('New Admin') }

						it "should be an admin user" do
							expect(admin).to be_admin
							expect(admin).not_to be_note_taker
						end
					end
				end
			end
		end
	end

	describe "signup noteuser page" do
		before { visit signup_noteuser_path }
		let(:cancel) { "Cancel" }


		it { should have_title(full_title('NoteUser Registration')) }
		it { should have_content('First') }

		describe "cancelling" do
			it "should not create a user" do
				expect { click_link cancel }.not_to change(User, :count)
			end
		end
	end

	describe "signup notetaker page" do
		before { visit signup_notetaker_path }
		let(:cancel) { "Cancel" }


		it { should have_title(full_title('NoteTaker Registration')) }
		it { should have_content('First') }

		describe "cancelling" do
			it "should not create a user" do
				expect { click_link cancel }.not_to change(User, :count)
			end
		end
	end

	describe 'profile page' do
		let(:notetaker) { FactoryGirl.create(:notetaker) }
		let(:course_m1) { FactoryGirl.create(:course) }
		let(:course_m2) { FactoryGirl.create(:course) }
		let!(:m1) { FactoryGirl.create(:note, user: notetaker, course: course_m1, comments: "Foo") }
    	let!(:m2) { FactoryGirl.create(:note, user: notetaker, course: course_m2, comments: "Bar") }
		before do
			sign_in notetaker
			visit user_path(notetaker) 
		end

		it { should have_content(full_title(notetaker.name)) }
		it { should have_title(full_title(notetaker.name)) }

		describe "notes" do
			it { should have_content(course_m1.subject_code + " " + course_m1.course_num) }
			it { should have_content(m1.lecture_title) }
			it { should have_content(m1.lecture_date) }
      	it { should have_content(m1.comments) }

			it { should have_content(course_m2.subject_code + " " + course_m2.course_num) }
      	it { should have_content(m2.lecture_title) }
			it { should have_content(m2.lecture_date) }
			it { should have_content(m2.comments) }

      	it { should have_content(notetaker.notes.count) }
      end
	end

	describe "noteuser signup" do
		
		before { visit signup_noteuser_path }

		let(:submit) { "Register" }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end

			describe "after submission" do
				before { click_button submit }

				it { should have_title('NoteUser Registration') }
				it { should have_content('error') }
			end
		end
			
		describe "with valid information" do
			before do
			  fill_in "Name",				with: "Example User"
			  fill_in "Email",			with: "example.user@mail.mcgill.ca"
			  fill_in "Student ID",		with: "111111111"
			  fill_in "Password",		with: "foobar11"
			  fill_in "Confirmation",	with: "foobar11"
			end

			it "should create a note user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end

			describe "after saving the note user" do
				before { click_button submit }
				let(:user) { User.find_by(email: 'example.user@mail.mcgill.ca') }

				it { should have_link('Sign out') }
				it { should have_title(full_title('')) }
				it { should have_success_message('Welcome') }

				it "should be a note user" do
					expect(user).not_to be_note_taker
				end
			end

			describe "#send new user registration email" do
 				it "should deliver email to user" do
   				last_email.to.should include (user.email)
 				end
			end
		end
	end
	describe "notetaker signup" do
		before { visit signup_notetaker_path }

		let(:submit) { "Register" }
		describe "with valid information" do
			before do
			  fill_in "Name",				with: "Example User"
			  fill_in "McGill Email",			with: "example.user@mail.mcgill.ca"
			  fill_in "Student ID",		with: "111111111"
			  fill_in "Password",		with: "foobar11"
			  fill_in "Confirmation",	with: "foobar11"
			end

			it "should create a note taker" do
				expect { click_button submit }.to change(User, :count).by(1)
			end

			describe "after saving the user" do
				before { click_button submit }
				let(:user) { User.find_by(email: 'example.user@mail.mcgill.ca') }

				it { should have_link('Sign out') }
				it { should have_title(full_title('')) }
				it { should have_success_message('Welcome') }

				it "should be a notetaker" do
					expect(user).to be_note_taker
				end
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
			it { should have_selector('legend', text: "Update your profile") }
			it { should have_title(full_title("Edit user")) }
		end

		describe "with valid information" do
			let(:new_name) { "New Name" }
			let(:new_id) { "932147891" }
			before do
			  fill_in "Name",	with: new_name
			  fill_in "Student ID",	with: new_id
			  click_button "Save changes"
			end

			it { should have_title(full_title('')) }
			it { should have_success_message('Profile updated') }
			it { should have_link('Sign out', href: signout_path) }
			specify { expect(user.reload.name).to eq new_name }
			specify { expect(user.reload.student_id).to eq new_id }
		end

		describe "forbidden attributes" do
			describe "forbidden admin" do
				let(:params) do
					{ user: { admin: true, 
								 password: user.password,
								 password_confirmation: user.password } }
				end
				before do
					sign_in user, no_capybara: true
					patch user_path(user), params 
				end
				specify { expect(user.reload).not_to be_admin }
			end

			describe "forbidden notetaker" do
				let(:params) do
					{ user: { note_taker: true, password: user.password,
									password_confirmation: user.password } }
				end
				before do
					sign_in user, no_capybara: true
					patch user_path(user), params 
				end
				specify { expect(user.reload).not_to be_note_taker }				
			end

			describe "forbidden email" do
				let(:params) do
					{ user: { email: "first.last@mail.mcgill.ca", password: user.password,
									password_confirmation: user.password } }
				end
				before do
					sign_in user, no_capybara: true
					patch user_path(user), params 
				end
				specify { expect(user.reload.email).not_to eq "first.last@mail.mcgill.ca" }				
			end

		end
	end
end
