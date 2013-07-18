namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		admin = User.create!(name: "Example User",
					 		 email: "example.user@mail.mcgill.ca",
					 		 student_id: "111111111",
					 		 admin: true)
		99.times do |n|
			name = Faker::Name.name
			email = "example.user#{n+1}@mail.mcgill.ca"
			id = (0..9).to_a.shuffle[0..8].join
			User.create!(name: name,
						 email: email,
						 student_id: id)
		end
	end
end