class CartProduct < ApplicationRecord
	belongs_to :client
	belongs_to :product

	validates :count,  presence: true
end
