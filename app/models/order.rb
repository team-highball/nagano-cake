class Order < ApplicationRecord

  has_many :order_products,   dependent: :destroy

  belongs_to :client

  validates :postal_code, :address, :name, :total_bill, :payment_method, :postage, :status,  presence: true

end
