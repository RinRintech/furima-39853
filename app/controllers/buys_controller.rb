class BuysController < ApplicationController
  def new
    @buydelivery = BuyDelivery.new
  end

  def create
    @buydelivery = BuyDelivery.new(buy_params)
    if @buydelivery.valid?
      @buydelivery.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
    
    def index
      @item = Item.find(params[:item_id])
      @buydelivery = BuyDelivery.new
    end


  
  private

  def buy_params
    params.require(:buydelivery).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(buy_id: current_buy.id)
  end
end
