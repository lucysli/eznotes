class AddNoteTakerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :note_taker, :boolean, default: false
  end
end
