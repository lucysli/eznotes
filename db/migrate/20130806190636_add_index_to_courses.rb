class AddIndexToCourses < ActiveRecord::Migration
  def up
    add_index :courses, [:subject_code, :course_num, :term, :section], unique: true, name: 'course_lookup_index'
  end

  def down
    remove_index :courses, [:subject_code, :course_num, :term, :section]
  end
end
