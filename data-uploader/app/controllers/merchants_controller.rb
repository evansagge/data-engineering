class MerchantsController < ApplicationController

  respond_to :html, :json, :xml

  def index
    @merchants = Merchant.page(params[:page]).per(10)
    respond_with @merchants
  end

  def show
    @merchant = Merchant.includes(:items, :purchases).find(params[:id])
    respond_with @merchant
  end

end