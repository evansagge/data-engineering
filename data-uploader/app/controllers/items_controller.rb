class ItemsController < ApplicationController

  respond_to :html, :json, :xml

  def index
    @items = Item.includes(:merchant, :purchases).page(params[:page]).per(10)
    respond_with @items
  end

  def show
    @item = Item.includes(:merchant, :purchases).find(params[:id])
    respond_with @item
  end

end