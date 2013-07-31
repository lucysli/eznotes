class ChangeCommentsForNotes < ActiveRecord::Migration
   def up
      change_column :notes, :comments, :text
   end
end
