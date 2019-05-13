FactoryBot.define do
  factory :bank_period do
    percentage { 45 }
    days { 60 }
    active { true }
    bank
  end

  trait(:inactive) do
    active { false }
  end
end
