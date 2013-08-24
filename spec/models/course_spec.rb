# == Schema Information
#
# Table name: courses
#
#  id           :integer          not null, primary key
#  course_title :string(255)
#  subject_code :string(255)
#  course_num   :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  term         :string(255)
#  section      :string(255)
#  user_id      :integer
#

require 'spec_helper'

describe Course do
  
  before do
    @course = Course.new(course_title: "Advanced calculus", subject_code: "MATH", 
                         course_num: "265", term: "fall", section: "001")
  end

  subject { @course }

  it { should respond_to(:course_title) }
  it { should respond_to(:subject_code) }
  it { should respond_to(:course_num) }
  it { should respond_to(:section) }
  it { should respond_to(:term) }
  it { should respond_to(:registrations) }
  it { should respond_to(:registered_users) }

  it { should respond_to(:notes) }
  it { should respond_to(:feed) }

  it { should respond_to(:user_id) }

  describe "when course_title is not present" do
     before { @course.course_title = nil }
     it { should_not be_valid }
  end

  describe "with blank course title" do
     before { @course.course_title = " " }
     it { should_not be_valid }
  end

  describe "when subject_code is not present" do
     before { @course.subject_code = nil }
     it { should_not be_valid }
  end

  describe "with blank subject code" do
     before { @course.subject_code = " " }
     it { should_not be_valid }
  end

  describe "with subject code that is not 4 characters" do
     it { should ensure_length_of(:subject_code).is_equal_to(4) }
  end

  describe "when subject code is wrong format" do
    it { should_not allow_value("MA1H").for(:subject_code) }
    it { should_not allow_value("1234").for(:subject_code) }
    it { should_not allow_value("1ATH").for(:subject_code) }
  end

  describe "when subject code is correct format" do
    it { should allow_value("MATH").for(:subject_code) }
    it { should allow_value("CHEM").for(:subject_code) }
    it { should allow_value("SOCI").for(:subject_code) }
  end

  describe "when course_num is not present" do
     before { @course.course_num = nil }
     it { should_not be_valid }
  end

  describe "with course num that is 3 characters long" do
    before { @course.course_num = "101" }
    it { should be_valid }
  end

  describe "with course num that is 5 characters long" do
    before { @course.course_num = "123D1" }
    it { should be_valid }
  end

  describe "with course num that is less than 3 character2" do
    before { @course.course_num = "12" }
    it { should_not be_valid }
  end

  describe "with course num that is greater than 5 characters" do
    before { @course.course_num = "123456" }
    it { should_not be_valid }
  end

  describe "with course num that is 4 characters long" do
    before { @course.course_num = "1234" }
    it { should_not be_valid }
  end

  describe "when course num is wrong format" do
    it { should_not allow_value("1234").for(:course_num) }
    it { should_not allow_value("123H1").for(:course_num) }
    it { should_not allow_value("111H").for(:course_num) }
    it { should_not allow_value("ABC").for(:course_num) }
    it { should_not allow_value("ABCDE").for(:course_num) }
    it { should_not allow_value("ABCD1").for(:course_num) }
  end

  describe "when course num is correct format" do
    it { should allow_value("123").for(:course_num) }
    it { should allow_value("101D1").for(:course_num) }
    it { should allow_value("102D2").for(:course_num) }
    it { should allow_value("201N1").for(:course_num) }
    it { should allow_value("203N2").for(:course_num) }
    it { should allow_value("450J1").for(:course_num) }
    it { should allow_value("451J2").for(:course_num) }
    it { should allow_value("452J3").for(:course_num) }
  end

  describe "when course is already in table" do
    before do
      duplicate_course = @course.dup
      duplicate_course.course_title = "new title"
      duplicate_course.save
    end
    it { should_not be_valid }
  end

  describe "when subject code is the same but" do
    let(:duplicate_course) { duplicate_course = @course.dup }

    describe "when course num differs" do
      before do
        duplicate_course.course_num = (@course.course_num.to_i + 1).to_s
        duplicate_course.save
      end
      it { should be_valid }
    end

    describe "when section differs" do
      before do
        duplicate_course.section = "002"
        duplicate_course.save
      end
      it { should be_valid }
    end

    describe "when term differs" do
      before do
        duplicate_course.term = "winter"
        duplicate_course.save
      end
      it { should be_valid }
    end
  end

   describe "subject code with mixed case" do
      let(:mixed_subject_code) { "MaTh" }

      it "should be saved as all upper-case" do
         @course.subject_code = mixed_subject_code
         @course.save
         expect(@course.reload.subject_code).to eq mixed_subject_code.upcase
      end
   end

  describe "when term is not present" do
     before { @course.term = nil }
     it { should_not be_valid }    
  end

  describe "with blank term " do
     before { @course.term = "" }
     it { should_not be_valid }    
  end

  describe "when term format is valid" do
    it "should be valid" do
      valid_terms = %w[fall winter summer]
      valid_terms.each do |valid_term|
         @course.term = valid_term
         expect(@course).to be_valid
      end
    end
  end

  describe "when term format is invalid" do
    it "should be invalid" do
      invalid_terms = %w[term1 spring term2 term3]
      invalid_terms.each do |invalid_term|
         @course.term = invalid_term
         expect(@course).not_to be_valid
      end
    end
  end

  describe "when section is not present" do
     before { @course.section = nil }
     it { should_not be_valid }    
  end

  describe "with blank section " do
     before { @course.section = "" }
     it { should_not be_valid }    
  end

  describe "note associations" do
     before { @course.save }
     let(:user) { FactoryGirl.create(:user) }
     let!(:older_note) do
      FactoryGirl.create(:note, user: user, course: @course, created_at: 1.day.ago)
     end
     let!(:newer_note) do
      FactoryGirl.create(:note, user: user, course: @course, created_at: 1.hour.ago)
     end

     it "should have the right notes in the right order" do
        expect(@course.notes.to_a).to eq [newer_note, older_note]
     end

     it "should destroy associated notes" do
      notes = @course.notes.to_a
      @course.destroy
      expect(notes).not_to be_empty
      notes.each do |note|
         expect(Note.where(id: note.id)).to be_empty
      end
     end
  end

  describe "registered user" do
   let(:user) { FactoryGirl.create(:user) }
   before do
     @course.save
     user.register!(@course)
   end
   its(:registered_users) { should include(user) }
   its(:note_taker) { should_not eq user }
  end

  describe "notetaker" do
    let(:notetaker) { FactoryGirl.create(:notetaker) }
    before do
      @course.user_id = notetaker.id
      @course.save
    end
    it { should be_valid }
    its(:note_taker) { should eq notetaker }

    describe "assigning a regular user as a notetaker for a course" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        @course.user_id = user.id
        @course.save
      end
      it { should_not be_valid }
      its(:note_taker) { should_not eq user }
    end
  end
end
