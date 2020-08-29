class Product < ApplicationRecord

    attachment :product_image

    has_many :cart_products,    dependent: :destroy
    has_many :order_products,   dependent: :destroy

    belongs_to :genre

    validates :name, :price,  presence: true

  # def self.sort(selection)
  #   case selection
	 #    when '1'
	 #      return self.order(price: :ASC)
	 #    when '2'
	 #      return self.order(price: :DESC)
  #   end
  # end



end
