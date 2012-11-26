require 'spec_helper'

describe MerchantsController do

  before { sign_in Fabricate(:user) }

  describe "GET index" do
    let!(:merchants) { 20.times { Fabricate(:merchant) } }

    before do
      get :index
    end

    it "renders the index page" do
      expect(response).to render_template :index
    end

    it "assigns Merchant objects to @merchants" do
      expect(assigns(:merchants)).to have(10).records
      assigns(:merchants).each do |record|
        expect(record).to be_a Merchant
      end
    end
  end

  describe "GET show" do
    let!(:merchant) { Fabricate(:merchant) }
    let!(:items) { 10.times.collect { Fabricate(:item, merchant: merchant) } }
    let!(:purchases) { 30.times.collect { Fabricate(:purchase, item: items.sample) } }

    before do
      get :show, id: merchant.id
    end

    it "renders the show page" do
      expect(response).to render_template :show
    end

    it "assigns the Merchant object to @merchant" do
      expect(assigns(:merchant)).to eq merchant
    end
  end

end