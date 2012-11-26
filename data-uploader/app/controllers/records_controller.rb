class RecordsController < ApplicationController

  respond_to :html, :json, :xml

  def index
    @records = Record.page(params[:page]).per(10)
    respond_with @records
  end

  def show
    @record = Record.find(params[:id])
    @purchases = @record.purchases.includes(:item, :merchant, :purchaser)
    @total_price = @record.purchases.sum(:total_price)
    respond_with @record
  end

  def create
    @record = Record.create(params[:record])
    if @record.valid? and @record.persisted?
      @record.process!

      if @record.success?
        flash[:notice] = "Record uploaded and processed."
      else
        flash[:notice] = "Record uploaded but not processed. Reason: #{@record.notes}."
      end
    end

    respond_with @record do |format|
      format.html { redirect_to(@record.success? ? @record : records_path) }
    end
  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy
    flash[:notice] = "Record was successfully removed."
    respond_with @record
  end
end