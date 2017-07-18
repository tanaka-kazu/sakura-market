class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :image
      t.integer :price
      t.text :description
      t.integer :disable_flg
      t.integer :sort_order

      t.timestamps
    end
  end
end
