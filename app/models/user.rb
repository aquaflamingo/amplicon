class User < ApplicationRecord
  include Clearance::User

  VALID_USERNAME = /\A(\w|\.)+\z/.freeze

  has_many :protocols
  has_many :favorite_protocols # setup relationship
  has_many :favorites, through: :favorite_protocols, source: :protocol

  # Who has followed this user
  has_many :follower_relationships, foreign_key: "followed_id", class_name: "Relationship"
  # Who has this user followed
  has_many :followed_relationships, foreign_key: "follower_id", class_name: "Relationship"

  has_many :followers, through: :follower_relationships, source: :follower
  has_many :following, through: :followed_relationships, source: :followed

  validates :username, 
    presence: true, 
    length: {minimum: 2, maximum: 20 },
    format: { with: VALID_USERNAME, message: 'Username can only include numbers, letters or underscores.'  }
end
