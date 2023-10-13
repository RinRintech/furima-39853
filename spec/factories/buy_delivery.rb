FactoryBot.define do
  factory :buy_delivery do
    postal_code { '123-4567' }
    prefecture_id { 1 }
    city { '中央区' }
    addresses { '銀座' }
    building { '' }
    phone_number { '09012345678' }
    token {"tok_abcdefghijk00000000000000000"}
  end
end
