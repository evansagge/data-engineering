class Purchase < ActiveRecord::Base
  attr_accessible :quantity, :purchaser, :merchant, :item, :record

  belongs_to :record, counter_cache: true
  belongs_to :purchaser, class_name: 'Person', counter_cache: true
  belongs_to :item, counter_cache: true
  belongs_to :merchant, counter_cache: true

  delegate :name, to: :purchaser, prefix: true
  delegate :description, :price, to: :item, prefix: true
  delegate :name, :address, to: :merchant, prefix: true

  scope :latest, ->(count) { order('purchases.created_at DESC').limit(count) }

  default_scope order('purchases.created_at DESC')

  before_save :calculate_total_price

  protected

  def calculate_total_price
    self.total_price = item_price * quantity
  end
end
