class Person < ActiveRecord::Base
  attr_accessible :name

  has_many :purchases, foreign_key: :purchaser_id

  scope :latest, ->(count) { order('people.created_at DESC').limit(count) }

  default_scope order('people.created_at DESC')

  def latest_purchase
    purchases.order('people.created_at DESC').first
  end

  def total_purchases
    purchases.sum(:total_price)
  end

end
