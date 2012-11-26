class Item < ActiveRecord::Base
  attr_accessible :description, :price

  belongs_to :merchant, counter_cache: true
  has_many :purchases, foreign_key: :item_id

  scope :latest, ->(count) { order('items.created_at DESC').limit(count) }

  default_scope order('items.created_at DESC')

  def total_purchases
    purchases.sum(&:total_price)
  end
end
