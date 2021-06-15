module ApplicationHelper

  def user_avatar(user, size=100)
    if user.avatar.attached?
      # TODO 
      user.avatar.variant(resize: "100x100")
    else 
"https://images.unsplash.com/photo-1502980426475-b83966705988?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=ddcb7ec744fc63472f2d9e19362aa387"
    end
  end
end
