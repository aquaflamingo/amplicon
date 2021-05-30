class Repository < ApplicationRecord
  # The type of repository
  enum resource: [:protocol]

  validates :name, presence: true, length: { minimum: 3, maximum: 20 }
  validates :description, presence: true, length: { minimum: 0, maximum: 140 }
  validates :resource, presence: true, inclusion: resources.keys

  after_create :initialize_bare_repository

  private 
  def initialize_bare_repository
    # TODO
  end
end
