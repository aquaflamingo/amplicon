# frozen_string_literal: true

module ApplicationHelper
  def user_avatar(user, size = 100)
    if user.avatar.attached?
      user.avatar.variant resize: "#{size}x#{size}"
    else
      gravatar_url user
    end
  end

  def gravatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "http://secure.gravatar.com/avatar/#{gravatar_id}"
  end

  def audit_version_count(model)
    model.audits.count
  end
end
