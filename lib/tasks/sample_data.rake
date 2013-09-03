
namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		make_users
		make_courses
		make_registrations
		#make_notes			
	end
end

def random_date from = Date.new(2010), to = Time.now.to_date
	rand(from..to)
end

def make_users
	admin = User.create!(name: 		"Example User",
			 		 			email: 		"example.user@mcgill.ca",
			 		 			student_id: "111111111",
			 		 			password:	"foobar11",
			 		 			password_confirmation: "foobar11",
			 		 			admin: true)
	50.times do |n|
		name = Faker::Name.name
		email = "example.user#{n+1}@mail.mcgill.ca"
		id = (0..9).to_a.shuffle[0..8].join
		password = "password"
		User.create!(name: 			name,
						 email: 			email,
						 student_id: 	id,
						 password:		password,
						 password_confirmation: password)
	end

	notetaker = User.create!(name: 			"Note Taker",
						 			 email: 		"note.taker@mail.mcgill.ca",
						 			 student_id: "000000000",
			 		 				 password:	"notetaker",
			 		 				 password_confirmation: "notetaker",
						 			 note_taker:   true)
end

def make_courses_helper(file, term)
	row_count = 0
	CSV.foreach(file, encoding: "ISO-8859-1") do |row|
		#puts "row number: #{row_count}"

      if row.nil? or row[0] == "CRN" or row[0].nil? or 
      	row[1].nil? or row[2].nil? or row[2].length == 4 or 
      	row[3].nil? or row[6].nil?
        	# if the cells we are interested in are nil 
        	# do not add the course or if its the header row
      else
			subject_code = row[1]
			course_num = row[2]
			if course_num.length == 1
         	course_num = "00" + course_num
        	elsif course_num.length == 2
         	course_num = "0" + course_num
        	end
			section = row[3]
			course_title = row[6]
			crn = row[0]

			#puts "CRN: #{crn}"
			#puts "Subject Code: #{subject_code}"
			#puts "Course Num: #{course_num}"
			#puts "Section: #{section}"
			#puts "Course Title: #{course_title}"
			#puts "Term: #{term}"
			# some strange course nums can exist like inter university transfer
			# like EXAR and IPAR so we should not add the course if its length is 4
			Course.create!(course_title: 	course_title,
							subject_code: 		subject_code, 
							course_num: 		course_num,
							term:					term,
							section:				section,
							crn:					crn) 
		end
		row_count += 1
	end
end

def make_courses
	path_fall = Rails.root.join('app', 'assets', 'files', 'Fall')
	path_winter = Rails.root.join('app', 'assets', 'files', 'Winter')
	Dir.glob("#{path_fall}/*.csv") do |file|
		puts "importing file: #{file}"
		term = "fall"
		make_courses_helper(file, term)
	end
	Dir.glob("#{path_winter}/*.csv") do |file|
		puts "importing file: #{file}"
		term = "winter"
		make_courses_helper(file, term)
	end
end

def make_registrations
	users = User.where("note_taker = ? AND admin = ?", false, false)
	courses = Course.all
	notetaker = User.find_by email: "note.taker@mail.mcgill.ca"

	users.each do |user|
		(0..9).each do |n|
			user.register!(courses[n])
		end 
	end

	5.times do |n|
		notetaker.register!(courses[n])
		courses[n].note_taker = notetaker
	end
	
end

def make_notes
	notetaker = User.find_by email: "note.taker@mail.mcgill.ca"
	file = File.new(Rails.root.join('public', 'assets', 'sample.pdf'))
	50.times do
		comments = Faker::Lorem.sentence(5)
		lecture_title = Faker::Lorem.word + " " + rand(100..999).to_s
		lecture_date = random_date()
		course = notetaker.registered_courses.sample
		notetaker.notes.create!(file: file,
									 comments: comments, 
									 lecture_title: lecture_title,
									 lecture_date: lecture_date,
									 course_id: course.id) 

	end
end





