FactoryBot.define do
  factory :department do
    sequence(:name) { |n| "Engineering #{n}" }

    trait :engineering do
      sequence(:name) { |n| "Engineering #{n}" }
    end

    trait :sales do
      sequence(:name) { |n| "Sales #{n}" }
    end

    trait :hr do
      sequence(:name) { |n| "Human Resources #{n}" }
    end

    trait :marketing do
      sequence(:name) { |n| "Marketing #{n}" }
    end
  end
end
