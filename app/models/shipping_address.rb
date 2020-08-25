class ShippingAddress < ApplicationRecord

  validates :postal_code,   presence: true
  validates :address,       presence: true
  validates :destination,   presence: true
  # validates :phone_number,  presence: true

end
