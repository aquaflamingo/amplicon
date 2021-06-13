module ProtocolsHelper
  def has_favorited?(user, protocol)
    user.favorites.exists?(protocol.id)
  end

  def render_visibility_badge(proto)
    if @proto.private?
      content_tag :span, class: "badge rounded-pill bg-dark text-light" do
        "Private"
      end
    else
      content_tag :span, class: "badge rounded-pill  bg-light text-dark" do
        "Public"
      end 
    end
  end
end
