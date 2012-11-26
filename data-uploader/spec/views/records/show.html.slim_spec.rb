require 'spec_helper'

describe "records/show.html.slim" do
  before do
    Record.any_instance.stub(:valid?).and_return true
  end

  let!(:record) { Fabricate(:record) }

  let!(:purchases) { 10.times.map{ Fabricate(:purchase, record: record) } }

  before do
    assign(:record, record)
    assign(:purchases, record.purchases)
    assign(:total_price, record.purchases.sum(:total_price))
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