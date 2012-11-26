class Merchant < ActiveRecord::Base
  attr_accessible :address, :name

  has_many :items
  has_many :purchases

  scope :latest, ->(count) { order('merchants.created_at DESC').limit(count) }

  default_scope order('merchants.created_at DESC')

  def total_purchases
    purchases.sum(&:total_price)
  end
end
