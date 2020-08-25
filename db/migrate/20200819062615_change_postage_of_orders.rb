class ChangePostageOfOrders < ActiveRecord::Migration[5.2]
  def up
    change_column :orders, :postage, :integer, default: 800
  end

  def down
    change_column :orders, :postage, :integer
  end
end
