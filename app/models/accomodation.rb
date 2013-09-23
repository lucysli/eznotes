# == Schema Information
#
# Table name: accomodations
#
#  id          :integer          not null, primary key
#  student_id  :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  note_taking :string(255)
#

class Accomodation < ActiveRecord::Base

  VALID_ID_REGEX = /\A\d+\z/i
  validates :student_id, presence: { message: "ID cannot be blank"} ,
                          format: { with: VALID_ID_REGEX, 
                           message: "ID is incorrect format; must be a 9 digit number" }, 
                          uniqueness: true,
                          length: { is: 9 }

  default_scope -> { order('created_at ASC') }

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    #spreadsheet = CSV.new(file.path, skip_blanks: true, encoding: "ISO-8859-1")

    # Find the header in the spreadsheet. WE cannot assume the header is in a particular
    # row in the spreadsheet
    header = []
    (2..spreadsheet.last_row).each do |i|
      if spreadsheet.row(i)[0] == "ID"
        header = spreadsheet.row(i)
        break
      end
    end

    # for each student in the spreadsheet store the accomodations
    accomodations = Hash.new   
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      if row.values != header and not row["ID"].nil? and not row["GENERAL ACCOMODATION CODE"].nil?
        
        student_id = row["ID"]
        accomodation_code = row["GENERAL ACCOMODATION CODE"].upcase

        if accomodations[student_id].nil?
          accomodations[student_id] = accomodation_code
        else
          accomodations[student_id] = accomodations[student_id] + "," + accomodation_code
        end
      end
    end

    # for each student find out if that student is already in our accomodations
    # database and compare their current accomodations with the new ones from the
    # spreadsheet
    accomodations.keys.each do |key|
      accomodation = find_by(student_id: key) || new
      accomodation.student_id = key
      if accomodation.note_taking.nil?
        accomodation.note_taking = accomodations[key]
      else
        accomodations[key].split(',').each do |code|
          if accomodation.note_taking.split(',').include?(code)
            accomodation.note_taking = accomodation.note_taking.split(',').delete(code)
          else
            accomodation.note_taking = accomodation.note_taking + "," + code
          end
        end
      end
      accomodation.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Roo::CSV.new(file.path, csv_options: {encoding: Encoding::ISO_8859_1})
    when '.xls' then Roo::Excel.new(file.path, {packed: nil, file_warning: :ignore})
    when '.xlsx' then Roo::Excelx.new(file.path, {packed: nil, file_warning: :ignore})
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
