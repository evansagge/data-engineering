require 'spec_helper'

describe "merchants/show.html.slim" do
  let!(:merchant) { Fabricate(:merchant) }
  let!(:items) { 5.times.collect{ Fabricate(:item, merchant: merchant) } }
  let!(:purchases) { 10.times.map{ Fabricate(:purchase, item: items.sample) } }

  before do
    assign(:merchant, merchant)
    render
  end

  it "shows the merchant's purchased items" do
    purchases.each do |purchase|
      expect(rendered).to contain purchase.item_description
    end
  end

  it "shows the total price for each purchase" do
    purchases.each do |purchase|
      expect(rendered).to contain number_to_currency purchase.total_price
    end
  end

  it "shows the total price for all purchases" do
    expect(rendered).to contain number_to_currency purchases.map(&:total_price).sum
  end
end