FactoryBot.define do
  factory :car do
    plate { 'ABC-1234' }

    trait :checkouted do
      status { 'checkouted' }
      check_out { Time.zone.now }

      after(:create) do |car|
        create(:payment, :paid, car: car)
      end
    end

    trait :with_payment do
      after(:create) do |car|
        create(:payment, car: car)
      end
    end

    trait :with_paid_payment do
      after(:create) do |car|
        create(:payment, :paid, car: car)
      end
    end
  end
end
