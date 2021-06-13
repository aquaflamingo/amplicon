module UsersHelper
  def find_current_user_relationship_to(user)
    current_user.active_relationships.find_by(followed_id: user.id )
  end

  def is_current_user?(u)
    current_user.id == u.id
  end
end
