# == Schema Information
#
# Table name: accomodations
#
#  id          :integer          not null, primary key
#  student_id  :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  note_taking :string(255)
#

require 'spec_helper'

describe Accomodation do
   before { @accomodation = Accomodation.new(student_id: "123456789") }

   subject { @accomodation }

   it { should respond_to(:student_id) }
   it { should respond_to(:note_taking) }

   it { should be_valid }

   describe "when student_id is not present" do
      before { @accomodation.student_id = nil }
      it { should_not be_valid }
   end

   describe "when student_id is not blank" do
      before { @accomodation.student_id = " " }
      it { should_not be_valid }
   end

   describe "when student id is too long" do
      before { @accomodation.student_id = "2" * 10 }
      it { should_not be_valid }
   end

   describe "when student id is too short" do
      before { @accomodation.student_id = "2" * 8 }
      it { should_not be_valid } 
   end

   describe "when student ID is already taken" do
      before do
        accomodation_with_same_id = @accomodation.dup
        accomodation_with_same_id.save
      end

      it { should_not be_valid }
   end

   describe "when student id is not numerical" do
      before { @accomodation.student_id = ("2" * 8) + "a" }
      it { should_not be_valid }
   end
end
