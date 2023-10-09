class BuyDelivery
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :buy_id, :postal_code, :prefecture_id, :city, :address, :building, :phone_number
  

  with_options presence: true do
    validates :buy_id, :postal_code, :prefecture_id, :city, :address, :phone_number
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'should be 10 to 11 digits long and contain only half-width numbers' }
  
  validates :prefecture, numericality: {other_than: 0, message: "can't be blank"}
  end

  def save
      buy = Buy.create(buy_id: buy_id)
      Delivery.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building: building, phone_number: phone_number)
  end
end