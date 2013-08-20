class AddIndexToCoursesSubjectCodeCourseNumTerm < ActiveRecord::Migration
  def up
   add_index :courses, [:subject_code, :course_num, :term], unique: true
  end
  def down
   remove_index :courses, [:subject_code, :course_num, :term]
  end
end
