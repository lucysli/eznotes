class CreateAccomodations < ActiveRecord::Migration
  def change
    create_table :accomodations do |t|
      t.string :student_id
      t.boolean :note_taking, default: false

      t.timestamps
    end
    add_index :accomodations, :student_id, unique: true
  end
end
