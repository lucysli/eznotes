class ChangeNoteTakingToStringInAccomodation < ActiveRecord::Migration
  def change
   change_column :accomodations, :note_taking, :string
  end
end
