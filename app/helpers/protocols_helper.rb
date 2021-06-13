module ProtocolsHelper
  def has_favorited?(user, protocol)
    user.favorites.exists?(protocol.id)
  end
end
