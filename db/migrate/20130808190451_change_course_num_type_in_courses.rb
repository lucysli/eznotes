class ChangeCourseNumTypeInCourses < ActiveRecord::Migration
  def change
   change_column :courses, :course_num, :string
  end
end
