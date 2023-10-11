FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    nickname { 'あお' }
    last_name { '高橋' }
    first_name { '碧' }
    last_name_kana { 'タカハシ' }
    first_name_kana { 'アオ' }
    date_of_birth { '1994-10-08' }
    password { 'abcd1234' }
  end
end