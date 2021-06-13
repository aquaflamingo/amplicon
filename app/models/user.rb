class User < ApplicationRecord
  include Clearance::User

  VALID_USERNAME = /\A(\w|\.)+\z/.freeze

  has_many :protocols
  has_many :favorite_protocols # setup relationship
  has_many :favorites, through: :favorite_protocols, source: :protocol

  validates :username, 
    presence: true, 
    length: {minimum: 2, maximum: 20 },
    format: { with: VALID_USERNAME, message: 'Username can only include numbers, letters or underscores.'  }
end
