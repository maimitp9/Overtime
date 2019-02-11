# create User
user = User.create(first_name: "Maimit", last_name: "Patel", email: "test@gmail.com", password: "123456", password_confirmation: "123456")

# create posts
100.times do |post|
  user.posts.create!(date: Date.today, rational: "#{post} rational content")
end

puts "100 posts have been created."