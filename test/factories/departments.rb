FactoryBot.define do
  factory :department do
    name { "Engineering" }

    trait :sales do
      name { "Sales" }
    end

    trait :hr do
      name { "Human Resources" }
    end

    trait :marketing do
      name { "Marketing" }
    end
  end
end
