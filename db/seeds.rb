5.times do |i|
  u = User.create!(
    username: "amplicon_user_#{i}",
    email: "user_#{i}@amplicon.app",
    password: "hunter#{i}"
  )

  other_users = User.all

  other_users.each do |other|
    u.follow(other)
    u.save
  end

  7.times do |i|
    p = u.protocols.create!(
      name: "protocol_#{i}",
      description: "A generated protocol",
      content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"
    )

    other_users.each do |other|
      other.favorite(p)
      other.save
    end
  end
end
