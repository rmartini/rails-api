FactoryBot.define do
  factory :bank do
    sequence(:name) { |n| "bank-#{n}" }
  end
end
