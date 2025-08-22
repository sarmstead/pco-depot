class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
