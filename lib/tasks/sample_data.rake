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

		def random_date from = Date.new(1970), to = Time.now.to_date
  			rand(from..to)
		end

		users = User.all(limit: 6)
		file = File.new(Rails.root.join('public', 'assets', 'sample.pdf'))
		50.times do
			comments = Faker::Lorem.sentence(5)
			lecture_title = Faker::Lorem.word + " " + rand(100..999).to_s
			lecture_date = random_date()
			users.each { |user| user.notes.create!(file: file,
																comments: comments, 
																lecture_title: lecture_title,
																lecture_date: lecture_date) }
		end


	end
end