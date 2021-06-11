class User < ApplicationRecord
  include Clearance::User

  has_many :protocols
end
