class BuysController < ApplicationController
  def new
    @buy = Buy.new
    @buy_delibvery = BuyDelivery.new
  end

  def create
    @buy_delibvery = BuyDelivery.new(buy_params)
    item_id = params[:item_id]
    @item = Item.find(item_id)
    @price = @item.price
    if @buy_delibvery.valid?
      pay_item
      @buy_delibvery.save
      redirect_to root_path
    else
      render 'index', status: :unprocessable_entity
      #render partial: 'shared/_error_messages', locals: { buy_delibvery: 'buy_deliverty' }
    end
  end
    
    def index
      @item = Item.find(params[:item_id])
      @buy_delibvery = BuyDelivery.new  
    end
  
  private

  def buy_params
    params.require(:buy_delivery).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(user_id: current_user.id,item_id: params[:item_id] , token: params[:token])
  end

  def pay_item
    Payjp.api_key = "sk_test_d36f11eaed3773f16458a5fe"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @price,  # 商品の値段
      card: buy_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end
