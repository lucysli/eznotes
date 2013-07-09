class AddIndexToUsersStudentId < ActiveRecord::Migration
  def change
  	add_index :users, :student_id, unique: true
  end
end
