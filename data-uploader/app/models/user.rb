class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid

  has_many :records

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }

  class << self

    def authenticate!(auth_hash)
      auth_hash.stringify_keys!
      find_or_initialize_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]).tap do |user|
        user.name = auth_hash["info"]["name"]
        user.save!
      end
    end

  end
end
