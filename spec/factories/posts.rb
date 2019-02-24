FactoryBot.define do
  factory :post do
    association :user, factory: :user 
    date { Date.today }
    rational { Faker::Lorem.sentence}
    overtime_request { 3.5 }
  end

  factory :second_post, class: "Post" do
    association :user, factory: :user 
    date { Date.yesterday }
    rational { Faker::Lorem.sentence }
    overtime_request { 2.5 }
  end

  factory :admin_post, class: "Post" do
    association :user, factory: admin_user
    date { Date.today }
    rational { Faker::Lorem.sentence}
    overtime_request { 3.0 }
  end

  factory :third_post, class: "Post" do
    association :user, factory: non_authorize_user
    date { Date.today }
    rational { Faker::Lorem.sentence}
    overtime_request { 2.0 }
  end
end