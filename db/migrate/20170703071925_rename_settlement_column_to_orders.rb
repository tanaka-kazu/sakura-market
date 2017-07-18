class RenameSettlementColumnToOrders < ActiveRecord::Migration[5.1]
  def change
    rename_column :orders, :settelment_charge, :settlement_charge
  end
end
