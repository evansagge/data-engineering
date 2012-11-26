class PurchasesController < ApplicationController

  respond_to :html, :json, :xml

  def index
    @purchases = Purchase.includes(:item, :merchant, :purchaser).page(params[:page]).per(10)
    @total_price = Purchase.sum(:total_price)
    respond_with @purchases
  end

end