# create User
user = User.create(first_name: "Maimit", last_name: "Patel", email: "regular@test.com", password: "123456", password_confirmation: "123456")
puts "1 user created"
AdminUser.create!(first_name: "Maimit", last_name: "Patel", email: "admin@test.com", password: "123456", password_confirmation: "123456")
puts "Admin User created"

# create posts
100.times do |post|
  user.posts.create!(date: Date.today, rational: "#{post} rational content")
end

puts "100 posts have been created."