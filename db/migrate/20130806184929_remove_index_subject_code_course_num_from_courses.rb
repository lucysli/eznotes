class RemoveIndexSubjectCodeCourseNumFromCourses < ActiveRecord::Migration
  def up
    remove_index :courses, [:subject_code, :course_num]
  end

  def down
    add_index :courses, [:subject_code, :course_num], unique: true
  end
end
