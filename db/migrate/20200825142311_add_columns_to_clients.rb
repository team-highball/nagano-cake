class AddColumnsToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :postcode, :integer
  end
end
