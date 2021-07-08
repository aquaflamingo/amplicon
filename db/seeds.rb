User.create!(
  username: "amplicon_user",
  email: "user_1@amplicon.app",
  password: "hunter1",
  display_name: "Amplicon User",
  description: "I am an amplicon user"
) unless User.exists?(username: "amplicon_user")

10.times do |i|
  name = Faker::Name.name
  email = Faker::Internet.email(name: name)
  username = Faker::Internet.username(specifier: name)
  description = "I am a #{Faker::Job.title} in #{Faker::Job.field}. I am interested in #{Faker::Science.element_subcategory} dynamics and #{Faker::Company.bs}. I work at #{Faker::Company.name}."

  u = User.create!(
    username: username,
    email: email,
    password: "hunter1",
    display_name: name,
    description: description
  )

  other_users = User.all

  other_users.each do |other|
    u.follow(other)
    u.save
  end

  2.times do |i|
    p = u.protocols.create!(
      name: "protocol_#{i}",
      description: "A #{Faker::Adjective.positive} generated protocol",
      content: "Lorem Ipsum"
    )

    other_users.each do |other|
      other.favorite(p)
      other.save
    end
  end
end
