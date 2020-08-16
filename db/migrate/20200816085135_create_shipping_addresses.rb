class CreateShippingAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_addresses do |t|

      t.integer     :client_id
      t.text        :address
      t.string      :destination
      t.string      :postal_code
      t.string      :phone_number
      t.timestamps
    end
  end
end
