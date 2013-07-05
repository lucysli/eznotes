require 'spec_helper'

describe User do
	before do
		@user = User.new(name: "Example User", email: "example.user@mail.mcgill.ca") 
	end

	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }

	it { should be_valid }

	describe "when name is not present" do
		before { @user.name = " " }
		it { should_not be_valid }
	end

	describe "when email is not present" do
		before { @user.email = " " }
		it { should_not be_valid }
  	end

  	describe "when name is too long" do
  		before { @user.name = "a" * 51 }
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
	    	addresses = %w[first.last@mail.mcgill.ca first.m.last@mail.mcgill.ca first.middle.last@mail.mcgill.ca first.last2@mail.mcgill.ca]
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
end
