require 'csv'

class Record < ActiveRecord::Base

  STATUSES = %w(pending processed failed)

  attr_accessible :raw_data, :notes, :user, :status

  has_many :purchases, dependent: :destroy

  has_attached_file :raw_data

  validates :raw_data, attachment_presence: true

  delegate :name, to: :user, prefix: true

  default_scope order('records.created_at DESC')

  def success?
    status == 'processed'
  end

  def failed?
    status == 'failed'
  end

  def process!
    header = File.foreach(raw_data.path).first

    if header =~ /^purchaser name/
      CSV.foreach(raw_data.path, col_sep: "\t", return_headers: false) do |row|
        next if row[0] =~ /^purchaser name/
        purchaser_name, item_description, item_price, quantity, merchant_address, merchant_name = row
        purchaser = Person.find_or_create_by_name(purchaser_name)
        merchant = Merchant.find_or_create_by_name_and_address(merchant_name, merchant_address)
        item = merchant.items.find_or_create_by_description_and_price(item_description, item_price)
        purchase = purchases.create!(
          item: item,
          merchant: merchant,
          purchaser: purchaser,
          quantity: quantity
        )
        self.status = "processed"
      end
    else
      self.status = 'failed'
      self.notes = "Invalid file"
    end
  rescue ArgumentError => e
    if e.message =~ /invalid byte sequence in UTF-8/
      self.status = 'failed'
      self.notes = "Invalid file type"
    else
      raise e
    end
  ensure
    self.save!
  end

end
