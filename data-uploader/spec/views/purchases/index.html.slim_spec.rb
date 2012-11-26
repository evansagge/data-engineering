require 'spec_helper'

describe "purchases/index.html.slim" do
  let!(:purchases) { 10.times.map{ Fabricate(:purchase) } }

  before do
    assign(:purchases, Purchase.page(0).per(10))
    assign(:total_price, Purchase.sum(&:total_price))
    render
  end

  it "shows the purchases" do
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