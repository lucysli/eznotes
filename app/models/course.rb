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

class Course < ActiveRecord::Base
   has_many :notes, dependent: :destroy
   has_many :registrations, foreign_key: "course_id", dependent: :destroy
   has_many :registered_users, through: :registrations, source: :user
   belongs_to  :note_taker, -> { where note_taker: true },
    class_name: "User", foreign_key: "user_id"


   before_save do
      subject_code.upcase!
      course_num.downcase!
      term.downcase!
      section.downcase!
   end  

   VALID_SUBJECT_CODE_REGEX = /\A[A-Za-z]{4}\z/i  
   VALID_TERM_REGEX = /\A(fall|winter|summer)\z/i 
   VALID_COURSE_NUM_REGEX = /\A\d{3}(D1|D2|N1|N2|J1|J2|J3)?\z/i

   validates :course_title, presence: true
   validates :subject_code, format: { with: VALID_SUBJECT_CODE_REGEX },
               presence: true, length: { is: 4 }, 
               uniqueness: { scope: [:course_num, :term, :section], case_sensitive: false }
   validates :course_num, 
               format: { with: VALID_COURSE_NUM_REGEX }, 
               presence: true,
               length: { 
                  minimum: 3,
                  maximum: 5,
                  wrong_length: "Course number must be a 3 digit number plus an optional two character code",
                  too_long: "Maximum number of characters accepted is: %{count} ",
                  too_short: "Minimum number of characters accepted is: %{count} "
               }
   validates :term, format:{ with: VALID_TERM_REGEX }, presence: true
   validates :section, presence: true

   def feed
      # This is preliminary.
      notes.where("course_id = ?", id)
   end

   def self.fall_courses
      # This is preliminary.
      Course.where("term= ?", "fall")
   end

   def self.winter_courses
      # This is preliminary.
      Course.where("term= ?", "winter")
   end

   def self.summer_courses
      # This is preliminary.
      Course.where("term= ?", "summer")
   end

   def assign_notetaker(user)
      self.notetaker = notetaker
   end

end
