class Customer < ApplicationRecord

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + last_name + ' ' + first_name
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :shipping_addresses
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy

end
