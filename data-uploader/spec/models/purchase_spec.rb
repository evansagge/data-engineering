require 'spec_helper'

describe Purchase do

  it { should belong_to(:purchaser).class_name("Person") }
  it { should belong_to :merchant }
  it { should belong_to :item }
  it { should belong_to :record }

  describe "#save" do
    let!(:purchase) { Fabricate.build(:purchase) }

    it "calculates the total price" do
      expect do
        purchase.save
      end.to change(purchase, :total_price).from(0.0).to(purchase.item_price * purchase.quantity)
    end

  end
end
