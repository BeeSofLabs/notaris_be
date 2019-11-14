class RenameNoFakPpatIntoFakPpat < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :no_fak_ppat, :fax_ppat
  end
end
