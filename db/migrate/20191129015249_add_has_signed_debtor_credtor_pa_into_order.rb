class AddHasSignedDebtorCredtorPaIntoOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :has_debtor_signed, :boolean, default: false
    add_column :orders, :has_creditor_signed, :boolean, default: false
    add_column :orders, :has_pa_signed, :boolean, default: false
  end
end
