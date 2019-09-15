FactoryBot.define do
  factory :user do
    login { FFaker::Name.unique.name }
  end
end
