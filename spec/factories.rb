FactoryGirl.define do
	factory :user do
		sequence(:name)			 { |n| "Firstname Lastname #{n}" }
		sequence(:email)		    { |n| "Firstname.Lastname#{n}@mail.mcgill.ca" }
		sequence(:student_id)    { |n| (n.to_s*9)[0..8] }

		factory :admin do
			admin true
		end
	end

   factory :note do
      file { File.new(Rails.root.join('public', 'assets', 'sample.pdf')) }
      lecture_title "Chem 200"
      lecture_date Date.today
      comments "testing the comments field"
      user
   end
end