class Customer < ApplicationRecord

  def self.guest
    find_or_create_by!(last_name: 'guest' ,first_name: 'user' ,email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.last_name = "guest"
      customer.first_name ="user"
      customer.postal_code = "0000000"
      customer.address = "東京都xx区"
      customer.phone_number = "00000000000"
    end
  end

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

  has_many :bookmarks, dependent: :destroy #ブックマークのことを指してる
  has_many :bookmarks_shops, through: :bookmarks, source: :shop #shopのテーブルのことを指してる


  def bookmark?(shop) #ブックマークされたショップにこのショップは含まれてるか？
    bookmarks_shops.include?(shop)
    #Bookmark.where(customer_id: id, shop_id: s.id).exists?と同じ
  end

end
