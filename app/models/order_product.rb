class OrderProduct < ApplicationRecord

  belongs_to :product
  belongs_to :order

  validates :order_id, :product_id, :price, :count, :making_status,  presence: true
end
