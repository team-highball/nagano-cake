class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_products,      dependent: :destroy
  has_many :orders,             dependent: :destroy
  has_many :shipping_addresses, dependent: :destroy

  validates :last_name,        presence: true
  validates :first_name,       presence: true
  validates :kana_last_name,   presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :kana_first_name,  presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :email,            presence: true
  validates :postal_code,      presence: true, length: { in: 7..8, message: "は７文字(ハイフンを除く)で入力してください。" }  
  validates :address,          presence: true
  validates :phone_number,     presence: true

  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
end
