require "spec_helper"

describe UserMailer do
  describe "password_reset" do
    let(:user) { FactoryGirl.create(:user, password_reset_token: "anything") }
    let(:mail) { UserMailer.password_reset(user) }

    it "sends user password reset url" do
      mail.subject.should eq("Password Reset")
      mail.to.should eq([user.email])
      mail.from.should eq(["mcgill.osd.eznotes@gmail.com"])
    end

    it "should assign the users name" do
      mail.body.encoded.should match(user.name)
    end

    it "renders the body" do
      mail.body.encoded.should match(edit_password_reset_path(user.password_reset_token))
    end
  end

  describe "new_registration" do
    let(:user) { FactoryGirl.create(:user) }
    let(:mail) { UserMailer.new_registration(user) }

    it "sends user new registration welcome message" do
      mail.subject.should eq("New Registration[McGill OSD EZnotes]")
      mail.to.should eq([user.email])
      mail.from.should eq(["mcgill.osd.eznotes@gmail.com"])
      mail.body.encoded.should match(user.name)
    end
  end

  describe "assign_notetaker" do
    let(:notetaker) { FactoryGirl.create(:notetaker) }
    let(:user) { FactoryGirl.create(:user) }
    let(:course) { FactoryGirl.create(:course) }
    let(:mail) { UserMailer.assign_notetaker(notetaker, course) }
    let(:mail_users) { UserMailer.notify_users(user, course) }

    before do
      notetaker.register!(course)
      user.register!(course)
      course.assign_note_taker(notetaker)
      course.save
    end

    it "sends notetaker you have been assigned to course message" do
      mail.subject.should eq("You Have Been Matched[McGill OSD EZnotes]")
      mail.to.should eq([notetaker.email])
      mail.from.should eq(["mcgill.osd.eznotes@gmail.com"])
      mail.body.encoded.should match(notetaker.name)
      mail.body.encoded.should match("#{course.term.upcase} | 
        #{course.subject_code} #{course.course_num} 
        #{course.section}: #{course.course_title}")
    end

    it "should send all note users registered with course message when a notetaker is assigned" do

      mail_users.subject.should eq("You Have Been Matched[McGill OSD EZnotes]")
      mail_users.to.should eq([user.email])
      mail_users.from.should eq(["mcgill.osd.eznotes@gmail.com"])
      mail_users.body.encoded.should match(user.name)
      mail_users.body.encoded.should match("#{course.term.upcase} | 
        #{course.subject_code} #{course.course_num} 
        #{course.section}: #{course.course_title}")
    end
  end

  describe "unassign_notetaker" do
    let(:notetaker) { FactoryGirl.create(:notetaker) }
    let(:user) { FactoryGirl.create(:user) }
    let(:course) { FactoryGirl.create(:course) }
    let(:mail) { UserMailer.unassign_notetaker(notetaker, course) }
    let(:mail_users) { UserMailer.warn_users(user, course) }

    before do
      notetaker.register!(course)
      user.register!(course)
      course.assign_note_taker(notetaker)
      course.unassign_note_taker
      course.save
    end

    it "sends notetaker you have been unassigned to course message" do
      mail.subject.should eq("You Have Been Unassigned[McGill OSD EZnotes]")
      mail.to.should eq([notetaker.email])
      mail.from.should eq(["mcgill.osd.eznotes@gmail.com"])
      mail.body.encoded.should match(notetaker.name)
      mail.body.encoded.should match("#{course.term.upcase} | 
        #{course.subject_code} #{course.course_num} 
        #{course.section}: #{course.course_title}")
    end

  end
end
