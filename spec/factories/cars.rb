FactoryBot.define do
  factory :car do
    plate { 'ABC-1234' }

    trait :checkouted do
      status { 'checkouted' }
    end
  end
end
