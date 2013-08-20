class RemoveIndexSubjectCodeCourseNumTermFromCourses < ActiveRecord::Migration
  def up
    remove_index :courses, [:subject_code, :course_num, :term]
  end

  def down
    add_index :courses, [:subject_code, :course_num, :term], unique: true
  end
end
