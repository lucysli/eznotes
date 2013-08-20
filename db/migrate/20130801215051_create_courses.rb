class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :course_title
      t.string :subject_code
      t.integer :course_num
      t.string :multi_term_code

      t.timestamps
    end
    add_index :courses, [:subject_code, :course_num], unique: true
  end
end
