require 'spec_helper'

describe ItemsController do

  before { sign_in Fabricate(:user) }

  describe "GET index" do
    let!(:items) { 20.times { Fabricate(:item) } }

    before do
      get :index
    end

    it "renders the index page" do
      expect(response).to render_template :index
    end

    it "assigns Item objects to @items" do
      expect(assigns(:items)).to have(10).records
      assigns(:items).each do |record|
        expect(record).to be_a Item
      end
    end
  end

  describe "GET show" do
    let!(:item) { Fabricate(:item) }
    let!(:purchases) { 30.times.collect { Fabricate(:purchase, item: item) } }

    before do
      get :show, id: item.id
    end

    it "renders the show page" do
      expect(response).to render_template :show
    end

    it "assigns the Item object to @item" do
      expect(assigns(:item)).to eq item
    end
  end

end