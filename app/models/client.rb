class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_products,      dependent: :destroy
  has_many :orders,             dependent: :destroy
  has_many :shipping_addresses, dependent: :destroy

  validates :first_name,      presence: true
  validates :last_name,       presence: true
  validates :kana_first_name, presence: true
  validates :kana_last_name,  presence: true
  validates :phone_number,    presence: true
  validates :postal_code,     presence: true
  validates :address,         presence: true



end
