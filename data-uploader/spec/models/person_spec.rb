require 'spec_helper'

describe Person do
  it { should have_many :purchases }

  let!(:person) { Fabricate(:person) }

  describe "#total_purchases" do
    let!(:purchases) { 5.times.collect { Fabricate(:purchase, purchaser: person) } }

    it "calculates the total price for all purchases by this person" do
      expect(person.total_purchases).to eq purchases.map(&:total_price).sum
    end
  end
end
