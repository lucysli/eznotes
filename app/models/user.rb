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

class User < ActiveRecord::Base
   has_many :notes, dependent: :destroy
   has_many :registrations, foreign_key: "user_id", dependent: :destroy
   has_many :registered_courses, through: :registrations, source: :course

   before_save { email.downcase! }
   before_create :create_remember_token
      
   validates :name, presence: true, 
                    length: { maximum: 50 }

   VALID_EMAIL_REGEX = /\A\w+\.([\w]+\.)?\w+(@mail.mcgill.ca|@mcgill.ca)\z/i
   validates :email, presence: true, 
                     format: { with: VALID_EMAIL_REGEX },
                     uniqueness: { case_sensitive: false }

   VALID_ID_REGEX = /\A\d{9}\z/i
   validates :student_id, presence: true,
                          format: { with: VALID_ID_REGEX }, 
                          uniqueness: true,
                          length: { is: 9 }


   has_secure_password
   validates :password, length: { minimum: 8 }

   def notetaking_for
      notetaking = []
      registered_courses.each do |course|
         if course.note_taker and course.note_taker == self
            notetaking.push course
         end
      end
      notetaking
   end

   def notes_feed
      Note.where("user_id = ?", id)
   end

   def fall_course_feed
      registered_courses.where("term = ?", "fall")
   end

   def winter_course_feed
      registered_courses.where("term = ?", "winter")
   end

   def summer_course_feed
      registered_courses.where("term = ?", "summer")
   end

   def registered_with?(course)
      registrations.find_by(course_id: course.id)
   end

   def register!(course)
      registrations.create!(course_id: course.id)
   end

   def unregister!(course)
      registrations.find_by(course_id: course.id).destroy!
   end

   def User.new_remember_token
      SecureRandom.urlsafe_base64
   end

   def User.encrypt(token)
      Digest::SHA1.hexdigest(token.to_s)
   end

   private

      def create_remember_token
         self.remember_token = User.encrypt(User.new_remember_token)
      end
end
