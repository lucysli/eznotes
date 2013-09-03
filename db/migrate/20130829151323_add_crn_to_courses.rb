class AddCrnToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :crn, :integer
    add_index :courses, :crn, unique: true
  end
end
