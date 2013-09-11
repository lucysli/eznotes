# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  student_id      :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#  note_taker      :boolean          default(FALSE)
#  password_digest :string(255)
#

require 'spec_helper'

describe User do
	before do
		@user = User.new(name: "Example User", email: "example.user@mail.mcgill.ca",
						         student_id: "260012345", password: "foobar11", 
                     password_confirmation: "foobar11") 
	end

	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
	it { should respond_to(:student_id) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  it { should respond_to(:notes) }
  it { should respond_to(:notes_feed) }
  it { should respond_to(:registrations) }
  it { should respond_to(:registered_courses) }
  it { should respond_to(:note_taker) }

	it { should be_valid }
  it { should_not be_admin }
  it { should_not be_note_taker }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe "with note taker attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:note_taker)
    end  

    it { should be_note_taker }  
  end

  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "example.user@mail.mcgill.ca",
                       student_id: "260012345", password: " ", 
                       password_confirmation: " ") 
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 7 }
    it { should be_invalid }
  end

  describe "when password format is invalid" do
    it "should be invalid" do
      passwords = %w[password' '''''''''' #{"passw rd"} #{"pass  rd"}]
        passwords.each do |invalid_password|
          @user.password = invalid_password
          expect(@user).not_to be_valid
      end
    end
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end

	describe "when name is not present" do
		before { @user.name = " " }
		it { should_not be_valid }
	end

	describe "when email is not present" do
		before { @user.email = " " }
		it { should_not be_valid }
  end

  	describe "when student id is not present" do
		before { @user.student_id = " " }
		it { should_not be_valid }
  end

  	describe "when name is too long" do
  		before { @user.name = "a" * 51 }
  		it { should_not be_valid }
  	end

	describe "when student id is too long" do
		before { @user.student_id = "2" * 10 }
		it { should_not be_valid }
	end

	describe "when student id is too short" do
		before { @user.student_id = "2" * 8 }
		it { should_not be_valid } 
	end

	describe "when student ID is already taken" do
		before do
		  user_with_same_id = @user.dup
		  user_with_same_id.email = "a" + @user.email
		  user_with_same_id.save
		end

		it { should_not be_valid }
	end

	describe "when student id is not numerical" do
		before { @user.student_id = ("2" * 8) + "a" }
		it { should_not be_valid }
	end

	describe "when email format is invalid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                   foo@bar_baz.com foo@bar+baz.com first..last@mail.mcgill.ca 
                   first.middle.more.last@mail.mcgill.ca example..user@mail.mcgill.ca
               	 example.middle..user@mail.mcgill.ca example..m.user@mail.mcgill.ca
               	 example.user@mail..mcgill.ca example.user@mail.mcgill..ca]
    		addresses.each do |invalid_address|
      		@user.email = invalid_address
      		expect(@user).not_to be_valid
			end
		end
	end

	describe "when email format is valid" do
    it "should be valid" do
    	addresses = %w[first.last@mail.mcgill.ca 
                     first.m.last@mail.mcgill.ca 
                     first.middle.last@mail.mcgill.ca 
                     first.last2@mail.mcgill.ca
                     first.last@mcgill.ca
                     first.m.last@mcgill.ca 
                     first.middle.last@mcgill.ca 
                     first.last2@mcgill.ca]
    		addresses.each do |valid_address|
     			@user.email = valid_address
      		expect(@user).to be_valid
    		end
    end
	end

	describe "when email address is already taken" do
		before do
		  user_with_same_email = @user.dup
		  user_with_same_email.email = @user.email.upcase
		  user_with_same_email.save
		end

		it { should_not be_valid }
	end

	describe "email address with mixed case" do
		let(:mixed_case_email) { "Foo.BlAh@MaIl.MCGill.Ca" }

		it "should be saved as all lower-case" do
			@user.email = mixed_case_email
			@user.save
			expect(@user.reload.email).to eq mixed_case_email.downcase
		end
	end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "note associations" do

    before { @user.save }
    let(:course) { FactoryGirl.create(:course) }
    let!(:older_note) do
      FactoryGirl.create(:note, user: @user, course: course, created_at: 1.day.ago)
    end
    let!(:newer_note) do
      FactoryGirl.create(:note, user: @user, course: course, created_at: 1.hour.ago)
    end

    it "should have the right notes in the right order" do
      expect(@user.notes.to_a).to eq [newer_note, older_note]
    end

    it "should destroy associated notes" do
      notes = @user.notes.to_a
      @user.destroy
      expect(notes).not_to be_empty
      notes.each do |note|
        expect(Note.where(id: note.id)).to be_empty
      end
    end

    describe "status" do
      let(:unfollowed_note) do
        FactoryGirl.create(:note, user: FactoryGirl.create(:user), course: course)
      end

      its(:notes_feed) { should include(newer_note) }
      its(:notes_feed) { should include(older_note) }
      its(:notes_feed) { should_not include(unfollowed_note) }
    end
  end

  describe "registering for courses" do
    let(:course) { FactoryGirl.create(:course) }
    before do
      @user.save
      @user.register!(course)             
    end

    it { should be_registered_with(course) }  
    its(:registered_courses) { should include(course) }  

    describe "and unregistering" do
      before { @user.unregister!(course) }

      it { should_not be_registered_with(course) }
      its(:registered_courses) { should_not include(course) }
    end 
  end

  describe "#send_password_reset" do
    it "should generate a unique password_reset_token each time" do
      @user.send_password_reset
      last_token = @user.password_reset_token
      @user.send_password_reset
      @user.password_reset_token.should_not eq(last_token)
    end

    it "should save the time the password reset was sent" do
      @user.send_password_reset
      @user.reload.password_reset_sent_at.should be_present
    end

    it "should deliver email to user" do
      @user.send_password_reset
      last_email.to.should include (@user.email)
    end
  end
end
