class ChangeNoteTakingFormatInAccomodation < ActiveRecord::Migration
  def change
   remove_column :accomodations, :note_taking, :string
   add_column :accomodations, :note_taking, :string
  end
end
