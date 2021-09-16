class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.belongs_to :order, null: false, foreign_key: true
      t.string :sku_belongs_to
      t.integer :quantity

      t.timestamps
    end
  end
end
