# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

3.times do |i| 
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
end

