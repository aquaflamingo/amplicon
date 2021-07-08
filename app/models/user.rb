# frozen_string_literal: true

class User < ApplicationRecord
  include Clearance::User

  VALID_USERNAME = /\A(\w|\.)+\z/.freeze
  VALID_DISPLAY_NAME = /\A(\w|\.)+ \z/.freeze

  has_one_attached :avatar

  has_many :protocols
  has_many :favorite_protocols # setup relationship
  has_many :favorites, through: :favorite_protocols, source: :protocol

  has_many :active_relationships,
           foreign_key: 'follower_id',
           class_name: 'Relationship',
           dependent: :destroy

  has_many :passive_relationships,
           foreign_key: 'followed_id',
           class_name: 'Relationship',
           dependent: :destroy

  has_many :followers, through: :passive_relationships, source: :follower
  has_many :following, through: :active_relationships, source: :followed

  validates :username,
            presence: true,
            length: { minimum: 2, maximum: 20 },
            format: { with: VALID_USERNAME, message: 'Username can only include numbers, letters or underscores.' }

  validates :display_name,
            length: { maximum: 20 },
            format: { with: VALID_DISPLAY_NAME, message: 'Display name can only include numbers, letters or underscores.' }

  validates :description,
            length: { maximum: 200 }


  after_create :set_default_name

  # Checks whether the User is following another user
  def following?(other_user)
    following.include?(other_user)
  end

  # Start following another user
  def follow(other_user)
    following << other_user unless other_user == self
  end

  # Unfollow an previously followed user
  def unfollow(other_user)
    following.delete(other_user)
 end

  def owns?(protocol)
    protocols.exists?(protocol.id)
  end

  private
  def set_default_name
    display_name = username
  end
end
