FactoryBot.define do
  factory :status do
    sequence(:label) { |n| "In #{n}" }
    color_code { "#2ecc71" }
    icon { "✓" }

    trait :out do
      sequence(:label) { |n| "Out #{n}" }
      color_code { "#e74c3c" }
      icon { "✗" }
    end

    trait :lunch do
      sequence(:label) { |n| "Lunch #{n}" }
      color_code { "#f39c12" }
      icon { "🍽" }
    end

    trait :meeting do
      sequence(:label) { |n| "Meeting #{n}" }
      color_code { "#3498db" }
      icon { "📅" }
    end

    trait :remote do
      sequence(:label) { |n| "Remote #{n}" }
      color_code { "#9b59b6" }
      icon { "🏠" }
    end

    trait :sick do
      sequence(:label) { |n| "Sick/Leave #{n}" }
      color_code { "#95a5a6" }
      icon { "🏥" }
    end
  end
end
