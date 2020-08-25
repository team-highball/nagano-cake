class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|

      t.integer     :client_id
      t.string      :postal_code
      t.string      :address
      t.string      :name
      t.integer     :total_bill
      t.integer     :payment_method
      t.integer     :postage
      t.integer     :status, :default => '1'
      t.timestamps
    end
  end
end
