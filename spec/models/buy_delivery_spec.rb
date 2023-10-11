require 'rails_helper'

RSpec.describe BuyDelivery, type: :model do
  describe '購入情報の保存' do
    before do
      #buy_delivery = FactoryBot.create(:buy_delivery)
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @buy_delivery = FactoryBot.build(:buy_delivery, user_id: user.id ,item_id: item.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@buy_delivery).to be_valid
      end
      it 'buildingは空でも保存できること' do
        @buy_delivery.building = ''
        expect(@buy_delivery).to be_valid
      end
      it "priceとtokenがあれば保存ができること" do
        expect(@buy_delivery).to be_valid
      end
    end

      context '内容に問題がある場合' do
        it 'postal_codeが空だと保存できないこと' do
          @buy_delivery.postal_code = ''
          @buy_delivery.valid?
          expect(@buy_delivery.errors.full_messages).to include("Postal code can't be blank")
        end
        it 'postal_codeは、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと' do
          @buy_delivery.postal_code = '1234567'
          @buy_delivery.valid?
          expect(@buy_delivery.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
        end
        it 'prefectureを選択していないと保存できないこと' do
          @buy_delivery.prefecture_id =  0 
          @buy_delivery.valid?
          expect(@buy_delivery.errors.full_messages).to include("Prefecture must be other than 0")
        end
        it 'cityが必須であること' do
          @buy_delivery.city = '  '
          @buy_delivery.valid?
          expect(@buy_delivery.errors.full_messages).to include("City can't be blank")
        end
        it 'addressesが必須であること' do
          @buy_delivery.addresses = ' '
          @buy_delivery.valid?
          expect(@buy_delivery.errors.full_messages).to include("Addresses can't be blank")
        end
        it 'phone_numberが必須であること' do
          @buy_delivery.phone_number = ' '
          @buy_delivery.valid?
          expect(@buy_delivery.errors.full_messages).to include("Phone number can't be blank")
        end
        it 'phone_numberは、10桁以上11桁以内の半角数値のみ保存可能なこと' do
          @buy_delivery.phone_number = '1234567890'
          @buy_delivery.phone_number = '12345678901'
          @buy_delivery.phone_number = '1234abcd567'
          @buy_delivery.valid?
          expect(@buy_delivery.errors.full_messages).to include("Phone number should be 10 to 11 digits long and contain only half-width numbers")
        end
        it "tokenが空では登録できないこと" do
          @buy_delivery.token = nil
          @buy_delivery.valid?
          expect(@buy_delivery.errors.full_messages).to include("Token can't be blank")
        end
      end
    end
  end
