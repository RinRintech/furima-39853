class BuyDelivery
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :buy_id, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number ,:token
  

  with_options presence: true do
    validates :postal_code, :prefecture_id, :city, :addresses, :phone_number, :token, :user_id ,:item_id
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'should be 10 to 11 digits long and contain only half-width numbers' }
  end

  validates :prefecture_id, numericality: {other_than: 0}
 

  def save
      buy = Buy.create(item_id: item_id ,user_id: user_id)
      Delivery.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, addresses: addresses, building: building, phone_number: phone_number, buy_id: buy.id)
  end
end