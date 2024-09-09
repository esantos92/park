FactoryBot.define do
  factory :payment do
    association :car

    trait :paid do
      status { 'paid' }
    end
  end
end
