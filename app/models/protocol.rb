class Protocol < ApplicationRecord

  VALID_NAME =  /\A(\w|\.)+\z/.freeze

  belongs_to :user
  has_many :favorite_protocols # setup relationship

  has_many :favorited_by, through: :favorite_protocols, source: :user

  # The type of protocol
  validates :name, presence: true, length: { minimum: 3, maximum: 20 }, format: { with: VALID_NAME, message: 'Protocol can only include numbers, letters or underscores.'  }
  validates :description, presence: true, length: { minimum: 0, maximum: 140 }

  has_rich_text :content

  audited associated_with: :content

  alias_attribute :owner, :user 
end
