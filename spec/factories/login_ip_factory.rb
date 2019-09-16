FactoryBot.define do
  factory :login_ip do
    login { FFaker::Name.unique.name }
    ip { FFaker::Internet.unique.ip_v4_address }
  end
end
