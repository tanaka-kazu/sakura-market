class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.datetime :order_date
      t.integer :delivery_info_id
      t.date :delivery_date
      t.integer :time_range_id
      t.integer :settelment_charge
      t.integer :delivery_charge

      t.timestamps
    end
  end
end
