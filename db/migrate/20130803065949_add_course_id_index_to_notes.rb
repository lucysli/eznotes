class AddCourseIdIndexToNotes < ActiveRecord::Migration
  def change
   add_index :notes, [:course_id, :created_at]
  end
end
