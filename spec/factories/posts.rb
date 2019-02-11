FactoryBot.define do
  factory :post do
    association :user, factory: :user 
    date { Date.today }
    rational { Faker::Lorem.sentence}
  end

  factory :second_post, class: "Post" do
    association :user, factory: :user 
    date { Date.yesterday }
    rational { Faker::Lorem.sentence }
  end
end