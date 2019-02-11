FactoryBot.define do
  factory :user do
    first_name { "Maimit" }
    last_name  { "Patel" }
    email { Faker::Internet.email }
    password { "123456" }
    password_confirmation { "123456" }
  end

  factory :admin_user, class: "AdminUser" do
    first_name { "Admin" }
    last_name  { "Patel" }
    email { Faker::Internet.email }
    password { "123456" }
    password_confirmation { "123456" }
  end
end