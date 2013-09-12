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
#  crn          :integer
#

class Course < ActiveRecord::Base
   has_many :notes, dependent: :destroy
   has_many :registrations, foreign_key: "course_id", dependent: :destroy
   has_many :registered_users, through: :registrations, source: :user
   belongs_to  :note_taker, class_name: "User", foreign_key: "user_id"

   default_scope -> { order('term ASC, subject_code ASC, course_num ASC, section ASC') }

   before_save do
      subject_code.upcase!
      course_num.downcase!
      term.downcase!
      section.downcase!
   end  

   VALID_SUBJECT_CODE_REGEX = /\A([A-Za-z]{4}|[A-Za-z]{3}\d)\z/i  
   VALID_TERM_REGEX = /\A(fall|winter|summer)\z/i 
   VALID_COURSE_NUM_REGEX = /\A\d{3}(D1|D2|N1|N2|J1|J2|J3)?\z/i

   validates :course_title, presence: true
   validates :subject_code, format: { with: VALID_SUBJECT_CODE_REGEX, message: "%{value} is incorrect format. Must be 4 alphabetical character subject code or a 3 alphabetical character subject code appended with a digit" },
               presence: true, length: { is: 4 }, 
               uniqueness: { scope: [:course_num, :term, :section], case_sensitive: false }
   validates :course_num, 
               format: { with: VALID_COURSE_NUM_REGEX, message: "%{value} is incorrect format" }, 
               presence: true,
               length: { 
                  minimum: 3,
                  maximum: 5,
                  wrong_length: "Course number must be a 3 digit number plus an optional two character code",
                  too_long: "Maximum number of characters accepted is: %{count} ",
                  too_short: "Minimum number of characters accepted is: %{count} "
               }
   validates :term, format:{ with: VALID_TERM_REGEX, message: "%{value} is incorrect format. Must be either fall winter or summer" }, presence: true
   validates :section, presence: true
   validates :crn, presence: true, uniqueness: { scope: :term, case_sensitive: false }, numericality: { only_integer: true }

   

   def feed
      # This is preliminary.
      notes.where("course_id = ?", id)
   end

   def self.fall_courses
      # This is preliminary.
      Course.where("term= ?", "fall").order("subject_code ASC, course_num ASC, section ASC")
   end

   def self.winter_courses
      # This is preliminary.
      Course.where("term= ?", "winter").order("subject_code ASC, course_num ASC, section ASC")
   end

   def self.summer_courses
      # This is preliminary.
      Course.where("term= ?", "summer").order("subject_code ASC, course_num ASC, section ASC")
   end

   def self.registered_courses
      Course.all.where("id IN (?)", Registration.distinct.pluck(:course_id))
   end

   def note_taker?(user)
      if self.note_taker
         self.note_taker == user
      else
         false
      end
   end

   def assign_note_taker(user)
      if user.note_taker
         self.note_taker = user
      else
         return false
      end
   end

   def unassign_note_taker
      self.note_taker = nil
   end

   def self.search(search)
      if search
         query = search.split
         where("subject_code ILIKE ? or
                course_num ILIKE ? or
                course_title ILIKE ? or
                (subject_code ILIKE ? and
                 course_num ILIKE ?)", 
                "%#{search}%",
                "%#{search}%",
                "%#{search}%",
                "%#{query[0]}%",
                "%#{query[1]}%").order('term ASC, subject_code ASC, course_num ASC, section ASC')
      else
         scoped
      end
   end

end
