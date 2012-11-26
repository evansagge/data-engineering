require 'spec_helper'

describe PurchasesController do

  before { sign_in Fabricate(:user) }

  describe "GET index" do
    let!(:purchases) { (5..20).to_a.sample.times { Fabricate(:purchase) } }

    before do
      get :index
    end

    it "renders the index page" do
      expect(response).to render_template :index
    end

    it "assigns Purchase objects to @purchases" do
      assigns(:purchases).each do |record|
        expect(record).to be_a Purchase
      end
    end
  end

end