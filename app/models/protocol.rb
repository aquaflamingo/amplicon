class Protocol < ApplicationRecord
  belongs_to :user

  # The type of protocol
  validates :name, presence: true, length: { minimum: 3, maximum: 20 }
  validates :description, presence: true, length: { minimum: 0, maximum: 140 }

  has_rich_text :reagents
  has_rich_text :equipment
  has_rich_text :materials
end
