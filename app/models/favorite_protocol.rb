# frozen_string_literal: true

class FavoriteProtocol < ApplicationRecord
  belongs_to :user
  belongs_to :protocol
end
