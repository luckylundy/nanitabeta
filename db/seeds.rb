30.times do
  user = User.create!(
    name: Faker::Games::Pokemon.unique.name,
    email: Faker::Internet.email,
    password: "password",
    password_confirmation: "password"
  )
end

User.limit(5).each do |user|  # 5人のユーザーを選んで各々をuserに代入
  15.times do |n|             # user1人につき15回投稿作成する
    micropost = user.microposts.create!(
      photo: open("./db/fixtures/#{n + 1}.jpeg"),
      detail: Faker::Hacker.say_something_smart
    )
    tag_list = ActsAsTaggableOn::Tag.new
    micropost.tag_list = Faker::Food.dish
    micropost.save
  end
end

