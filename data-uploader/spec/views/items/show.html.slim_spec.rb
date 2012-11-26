require 'spec_helper'

describe "items/show.html.slim" do
  let!(:item) { Fabricate(:item) }
  let!(:purchases) { 10.times.map{ Fabricate(:purchase, item: item) } }

  before do
    assign(:item, item)
    render
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