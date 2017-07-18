class CreateDeliveryInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :delivery_infos do |t|
      t.integer :user_id
      t.string :name
      t.string :address

      t.timestamps
    end
  end
end
