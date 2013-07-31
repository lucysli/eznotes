class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :lecture_title
      t.date :lecture_date
      t.string :comments
      t.integer :user_id

      t.timestamps
    end
    add_index :notes, [:user_id, :created_at]
  end
end
