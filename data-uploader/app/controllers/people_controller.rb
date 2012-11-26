class PeopleController < ApplicationController

  respond_to :html, :json, :xml

  def index
    @people = Person.page(params[:page]).per(10)
    respond_with @people
  end

  def show
    @person = Person.includes(purchases: [:item, :merchant, :purchaser]).find(params[:id])
    respond_with @person
  end

end