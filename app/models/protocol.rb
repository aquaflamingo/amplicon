class Protocol < ApplicationRecord
  belongs_to :user
  has_many :favorite_protocols # setup relationship

  has_many :favorited_by, through: :favorite_protocols, source: :user

  # The type of protocol
  validates :name, presence: true, length: { minimum: 3, maximum: 20 }
  validates :description, presence: true, length: { minimum: 0, maximum: 140 }

  has_rich_text :reagents
  has_rich_text :equipment
  has_rich_text :materials

  alias_attribute :owner, :user 
end
