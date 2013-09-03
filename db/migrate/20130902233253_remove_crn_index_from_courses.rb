class RemoveCrnIndexFromCourses < ActiveRecord::Migration
  def up
    remove_index :courses, :crn
  end

  def down
    add_index :courses, :crn, unique: true
  end
end
