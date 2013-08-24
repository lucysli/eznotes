FactoryGirl.define do
	factory :user do
		sequence(:name)			 { |n| "Firstname Lastname #{n}" }
		sequence(:email)		    { |n| "Firstname.Lastname#{n}@mail.mcgill.ca" }
		sequence(:student_id)    { |n| (n.to_s*9)[0..8] }
      password                 "foobar11"
      password_confirmation    "foobar11"

		factory :admin do
			admin true
		end

      factory :notetaker do
         note_taker true
      end
	end

   factory :course do
      sequence(:course_title)          { |n| "Advanced calculus #{n}" }
      subject_code                     "MATH"
      sequence(:course_num)            { |n| "#{n + 100 - 1}" }
      section                          "001"
      term                             "fall"

      factory :realcourse do
         course_title "Anthropology Beyond the Human."
         subject_code "ANTH"
         course_num "501"
         section "002"
         term "fall"
      end
   end



   factory :note do
      file { File.new(Rails.root.join('public', 'assets', 'sample.pdf')) }
      lecture_title "Chem 200"
      lecture_date Date.today
      comments "testing the comments field"
      user
      course
   end
end