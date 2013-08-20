# == Schema Information
#
# Table name: registrations
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  course_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Registration do
  
  let(:user) { FactoryGirl.create(:user) }
  let(:course) { FactoryGirl.create(:course) }
  let(:registration) { user.registrations.build(course_id: course.id) }

  subject { registration }

  it { should be_valid }

  describe "user methods" do
     it { should respond_to(:user) }
     it { should respond_to(:course) }
     its(:user) { should eq user}
     its(:course) { should eq course}
  end

  describe "when user id is not present" do
     before { registration.user_id = nil }
     it { should_not be_valid }
  end

  describe "when course id is not present" do
     before { registration.course_id = nil }
     it { should_not be_valid }
  end
end
