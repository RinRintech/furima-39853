class BuysController < ApplicationController
  def new
    @buy = Buy.new
    @buy_delibvery = BuyDelivery.new
  end

  def create
    @buy_delibvery = BuyDelivery.new(buy_params)
    if @buy_delibvery.valid?
      @buy_delibvery.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
    
    def index
      @item = Item.find(params[:item_id])
      @buy_delibvery = BuyDelivery.new  
    end
  
  private

  def buy_params
    params.require(:buy_delibvery).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(buy_id: current_buy.id)
  end
end
