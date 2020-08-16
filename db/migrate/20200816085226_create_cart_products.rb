class CreateCartProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_products do |t|

      t.integer     :product_id
      t.integer     :client_id
      t.integer     :count
      t.timestamps
    end
  end
end
