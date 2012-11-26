require 'spec_helper'

describe RecordsController do

  before { sign_in Fabricate(:user) }

  describe "GET index" do
    before do
      Record.any_instance.stub(:valid?).and_return true
    end

    let!(:records) { 20.times { Fabricate(:record) } }

    before do
      get :index
    end

    it "renders the index page" do
      expect(response).to render_template :index
    end

    it "assigns Record objects to @records" do
      expect(assigns(:records)).to have(10).records
      assigns(:records).each do |record|
        expect(record).to be_a Record
      end
    end
  end

  describe "GET show" do
    before do
      Record.any_instance.stub(:valid?).and_return true
    end

    let!(:record) { Fabricate(:record) }

    before do
      get :show, id: record.id
    end

    it "renders the show page" do
      expect(response).to render_template :show
    end

    it "assigns the Record object to @record" do
      expect(assigns(:record)).to eq record
    end
  end

  describe "POST create" do
    context "with valid inputs" do
      before do
        Record.any_instance.stub(:valid?).and_return true
        Record.any_instance.stub(:process!)
      end

      it "saves the Record" do
        expect do
          post :create, record: { notes: "test" }
        end.to change(Record, :count).by(1)
      end

      it "processes the Record" do
        Record.any_instance.should_receive(:process!)
        post :create, record: { notes: "test" }
      end

      it "redirects back to the index page" do
        post :create, record: { notes: "test" }
        expect(response).to redirect_to action: :index
      end
    end

    context "with invalid inputs" do
      before do
        Record.any_instance.stub(:valid?).and_return false
      end

      it "does not save any Record" do
        expect do
          post :create, record: { notes: "test" }
        end.to_not change(Record, :count)
      end

      it "does not process any Record" do
        Record.any_instance.should_not_receive(:process!)
        post :create, record: { notes: "test" }
      end

      it "redirects back to the index page" do
        post :create, record: { notes: "test" }
        expect(response).to redirect_to action: :index
      end
    end
  end

  describe "DELETE destroy" do
    before do
      Record.any_instance.stub(:valid?).and_return true
    end

    let!(:record) { Fabricate(:record) }

    it "deletes the Record from the database" do
      expect do
        delete :destroy, id: record.id
      end.to change(Record, :count).by(-1)
      expect { Record.find(record.id) }.to raise_exception ActiveRecord::RecordNotFound
    end

      it "redirects back to the index page" do
        delete :destroy, id: record.id
        expect(response).to redirect_to action: :index
      end
  end


end