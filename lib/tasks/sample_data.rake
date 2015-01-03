namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Konstantinos Christofilos",
                 email: "kostasxx@gmail.com",
                 password: "123456",
                 password_confirmation: "123456")
    admin.toggle!(:admin)
    
    User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "111111",
                 password_confirmation: "111111")
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
  end
end