FactoryBot.define do
  factory :status_log do
    association :user
    association :status
    note { nil }

    trait :with_note do
      note { "Working from office" }
    end

    trait :recent do
      created_at { 1.hour.ago }
    end

    trait :old do
      created_at { 2.days.ago }
    end
  end
end
