class RemoveMultiTermCodeFromCourses < ActiveRecord::Migration
  def up
    remove_column :courses, :multi_term_code
  end

  def down
    add_column :courses, :multi_term_code, :string
  end
end
