require 'faker'

30.times do
  user = User.new(
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    username: Faker::FunnyName.name,
    password: 'password',
    birthday: Time.now
  )
  user.save
end

User.all.each do |q|
  22.times do
    posty = Post.new(
    title: 'my muse',
    content: Faker::BojackHorseman.quote,
    creator: q.username,
    post_time: Time.now,
    user_id: q.id
    )
    posty.save
  end
end
