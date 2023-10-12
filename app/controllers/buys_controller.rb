class BuysController < ApplicationController
  before_action :set_public_key, only: [:index, :create]
  before_action :authenticate_user!, only: [:show, :index]

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
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render 'index', status: :unprocessable_entity
      #render partial: 'shared/_error_messages', locals: { buy_delibvery: 'buy_deliverty' }
    end
  end
    
    def index
      @item = Item.find(params[:item_id])
      @buy_delibvery = BuyDelivery.new  
      if current_user.id == @item.user.id
        redirect_to root_path
      end
      if @item.buy.present?
        redirect_to root_path
      end
    end
  
  private

  def buy_params
    params.require(:buy_delivery).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(user_id: current_user.id,item_id: params[:item_id] , token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @price,  # 商品の値段
      card: buy_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

  def set_public_key
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end

end
