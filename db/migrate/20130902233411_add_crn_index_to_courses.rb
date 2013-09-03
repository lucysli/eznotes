class AddCrnIndexToCourses < ActiveRecord::Migration
  def change
    add_index :courses, [:crn, :term], unique: true
  end
end
