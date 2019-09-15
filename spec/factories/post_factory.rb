FactoryBot.define do
  factory :post do
    title { FFaker::Book.title }
    body { FFaker::Tweet.body }
    ip { FFaker::Internet.unique.ip_v4_address }
    rating { Random.rand(1..5) }
    association :user, factory: :user
  end
end
