class AddAttachmentFileToNotes < ActiveRecord::Migration
  def self.up
    change_table :notes do |t|
      t.attachment :file
    end
  end

  def self.down
    drop_attached_file :notes, :file
  end
end
