
namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		make_users
		make_courses
		make_registrations
		make_notes			
	end
end

def random_date from = Date.new(1970), to = Time.now.to_date
	rand(from..to)
end

def make_users
	admin = User.create!(name: 		"Example User",
			 		 			email: 		"example.user@mail.mcgill.ca",
			 		 			student_id: "111111111",
			 		 			admin: true)
	99.times do |n|
		name = Faker::Name.name
		email = "example.user#{n+1}@mail.mcgill.ca"
		id = (0..9).to_a.shuffle[0..8].join
		User.create!(name: 			name,
						 email: 			email,
						 student_id: 	id)
	end
end

def make_courses
	filepaths = Hash.new
	filepaths["fall"] = Rails.root.join('app', 'assets', 'files', 'Fall', 'Arts.csv')
	filepaths["winter"] = Rails.root.join('app', 'assets', 'files', 'Winter', 'Science.csv')
	filepaths.each_key { |key| 
		term = key.dup
		CSV.foreach(filepaths[key], encoding: "ISO-8859-1") do |row|
			if row[0] == "CRN" or row[1].nil? or row[2].nil? or row[3].nil? or row[6].nil?
				# if the cells we are interested in are nil 
				# do not add the course or if its the header row
			else
				subject_code = row[1]
				course_num = row[2]
				section = row[3]
				course_title = row[6]
				# some strange course nums can exist like inter university transfer
				# like EXAR and IPAR so we should not add the course if its length is 4
				Course.create!(course_title: 	course_title,
								subject_code: 		subject_code, 
								course_num: 		course_num,
								term:					term,
								section:				section) unless course_num.length == 4
			end
		end
	}
end

def make_registrations
	users = User.all
	courses = Course.all

	users.each do |user|
		(0..9).each do
			user.register!(courses[rand(0..courses.size)])
		end 
	end
	
end

def make_notes
	users = User.all(limit: 6)
	file = File.new(Rails.root.join('public', 'assets', 'sample.pdf'))
	50.times do
		comments = Faker::Lorem.sentence(5)
		lecture_title = Faker::Lorem.word + " " + rand(100..999).to_s
		lecture_date = random_date()
		users.each { |user| user.notes.build(file: file,
															comments: comments, 
															lecture_title: lecture_title,
															lecture_date: lecture_date,
															course_id: user.registered_courses.sample.id) }
	end
end





