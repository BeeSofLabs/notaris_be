class AddFidusiaFields < ActiveRecord::Migration[5.2]
  def change
    rename_column :fidusia_orders, :on_behalf_of, :name_representative
    rename_column :fidusia_orders, :number_of_evidence, :no_evidence
    add_column :fidusia_orders, :color, :string
    rename_column :fidusia_orders, :tipe, :classification
  end
end
