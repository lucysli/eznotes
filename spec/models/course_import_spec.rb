require 'spec_helper'

describe CourseImport do
   before do
      @import = CourseImport.new(file: Rails.root.join('app', 'assets', 'files', 'Fall', 'all.csv'), term: "fall")
   end

   subject { @import }

   it { should respond_to(:file) }
   it { should respond_to(:term) }

   it { should be_valid }


   describe "when file is not present" do
      before { @import.file = nil }
      it { should_not be_valid }
   end

   describe "when term is not present" do
      before { @import.term = nil }
      it { should_not be_valid }
   end

   describe "when file is not the correct format" do
   end

   describe "when file is not the correct format" do
      it "should be invalid" do
         files = %w[all.xcs arts.doc arts.ppt blah.text blah.xml]
         files.each do |invalid_file|
            @import.file = invalid_file
            expect(@import).not_to be_valid
         end
      end
   end

   describe "when file format is valid" do
    it "should be valid" do
      files = %w[all.csv arts.csv science.csv]
         files.each do |invalid_file|
            @import.file = invalid_file
            expect(@import).to be_valid
         end
    end
   end
end