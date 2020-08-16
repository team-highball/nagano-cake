class CreateOrderProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :order_products do |t|

      t.integer     :order_id
      t.integer     :product_id
      t.integer     :price
      t.integer     :count
      t.integer     :making_status, :default => '1'
      t.timestamps
    end
  end
end
