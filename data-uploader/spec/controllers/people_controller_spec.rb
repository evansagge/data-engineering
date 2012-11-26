require 'spec_helper'

describe PeopleController do

  describe "GET index" do
    let!(:persons) { 20.times { Fabricate(:person) } }

    before do
      get :index
    end

    it "renders the index page" do
      expect(response).to render_template :index
    end

    it "assigns Person objects to @people" do
      expect(assigns(:people)).to have(10).records
      assigns(:people).each do |record|
        expect(record).to be_a Person
      end
    end
  end

  describe "GET show" do
    let!(:person) { Fabricate(:person) }
    let!(:purchases) { 30.times.collect { Fabricate(:purchase, purchaser: person) } }

    before do
      get :show, id: person.id
    end

    it "renders the show page" do
      expect(response).to render_template :show
    end

    it "assigns the Person object to @person" do
      expect(assigns(:person)).to eq person
    end
  end

end