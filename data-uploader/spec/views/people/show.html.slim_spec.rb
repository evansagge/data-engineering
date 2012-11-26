require 'spec_helper'

describe "people/show.html.slim" do
  let!(:person) { Fabricate(:person) }
  let!(:purchases) { 10.times.map{ Fabricate(:purchase, purchaser: person) } }

  before do
    assign(:person, person)
    render
  end

  it "shows the person's purchases" do
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