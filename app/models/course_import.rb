class CourseImport
  include ActiveModel::Model

  attr_accessor :file, :term

  validates :file, presence: true
  validates :term, presence: true

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save
    if imported_courses.map(&:valid?).all?
      imported_courses.each(&:save!)
      true
    else
      imported_courses.each_with_index do |course, index|
        course.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_courses
    @imported_courses ||= load_imported_courses
  end

  def load_imported_courses
    if file.nil? or File.extname(file[0].original_filename) != ".csv"
      return []
    end

    spreadsheet = CSV.read(file[0].path, skip_blanks: true, encoding: "ISO-8859-1")

    (1..spreadsheet.length).map do |i|
      row = spreadsheet[i]
      if row.nil? or row[0] == "CRN" or row[0].nil? or 
        row[1].nil? or row[2].nil? or row[2].length == 4 or 
        row[3].nil? or row[6].nil?
        # if the cells we are interested in are nil 
        # do not add the course or if its the header row
      else
        crn = row[0]
        subject_code = row[1]
        course_num = row[2]
        if course_num.length == 1
          course_num = "00" + course_num
        elsif course_num.length == 2
          course_num = "0" + course_num
        end
        section = row[3]
        if section.length == 1
          section = "00" + section
        elsif section.length == 2
          section = "0" + section
        end
        course_title = row[6]
        # some strange course nums can exist like inter university transfer
        # like EXAR and IPAR so we should not add the course and skip it
        # first search to see if this course exists already
        course = Course.find_by(crn: crn, term: term) || Course.new

        course.crn = crn
        course.course_title = course_title
        course.subject_code = subject_code
        course.course_num = course_num
        course.term = term
        course.section = section
        course
      end
    end.compact
  end
end