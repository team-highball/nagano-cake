class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|

      t.integer     :genre_id
      t.string      :name
      t.integer     :price
      t.string      :product_image_id
      t.text        :introduction
      t.integer     :is_active, :default => '1'
      t.timestamps
    end
  end
end
