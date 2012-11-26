require 'spec_helper'

describe Record do

  it { should have_many :purchases }

  it { should belong_to :user }

  context "Given valid raw data" do
    let!(:record) { Record.create(raw_data: File.new(Rails.root.join("spec/fixtures/example_input.tab"))) }

    describe "#process!" do
      line_data = [
        ["Snake Plissken", "$10 off $20 of food", "10.0", "2", "987 Fake St", "Bob's Pizza"],
        ["Amy Pond", "$30 of awesome for $10", "10.0", "5", "456 Unreal Rd", "Tom's Awesome Shop"],
        ["Marty McFly", "$20 Sneakers for $5", "5.0", "1", "123 Fake St", "Sneaker Store Emporium"],
        ["Snake Plissken", "$20 Sneakers for $5", "5.0", "4", "123 Fake St", "Sneaker Store Emporium"]
      ]

      it "creates unique Purchase records" do
        expect { record.process! }.to change(Purchase, :count).by(line_data.size)
        line_data.each do |purchaser_name, item_description, item_price, quantity, merchant_address, merchant_name|
          expect(Purchase.includes(:item, :merchant, :purchaser).where(
            people: { name: purchaser_name },
            items: { description: item_description, price: item_price },
            merchants: { name: merchant_name, address: merchant_address },
            quantity: quantity
          )).to exist
        end
      end

      it "creates unique Person records" do
        purchaser_names = line_data.transpose[0].uniq
        expect { record.process! }.to change(Person, :count).by(purchaser_names.count)
        purchaser_names.each do |name|
          expect(Person.where(name: name)).to have(1).record
        end
      end

      it "creates unique Merchant records with associated Item records" do
        merchant_hash = line_data.group_by{|r| [r[5], r[4]] }
        expect { record.process! }.to change(Merchant, :count).by(merchant_hash.count)
        merchant_hash.each do |merchant, items|
          merchant_name, merchant_address = merchant
          expect(Merchant.where(name: merchant_name, address: merchant_address)).to have(1).record

          merchant = Merchant.where(name: merchant_name, address: merchant_address).first
          items.group_by{|r| [r[1], r[2]]}.keys.each do |item_description, item_price|
            expect(merchant.items.where(description: item_description, price: item_price)).to have(1).record
          end
        end
      end
    end

    describe "#destroy" do
      it "destroys all associated Purchase records" do
        record.process!
        expect{ record.destroy }.to change(Purchase, :count).by(-4)
      end
    end
  end

end
