class ShippingAddress < ApplicationRecord

  validates :address,       presence: true
  validates :destination,   presence: true
  validates :postal_code,   presence: true
  validates :phone_number,  presence: true
  
end
