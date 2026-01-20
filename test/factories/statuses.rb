FactoryBot.define do
  factory :status do
    label { "In" }
    color_code { "#2ecc71" }
    icon { "✓" }

    trait :out do
      label { "Out" }
      color_code { "#e74c3c" }
      icon { "✗" }
    end

    trait :lunch do
      label { "Lunch" }
      color_code { "#f39c12" }
      icon { "🍽" }
    end

    trait :meeting do
      label { "Meeting" }
      color_code { "#3498db" }
      icon { "📅" }
    end

    trait :remote do
      label { "Remote" }
      color_code { "#9b59b6" }
      icon { "🏠" }
    end

    trait :sick do
      label { "Sick/Leave" }
      color_code { "#95a5a6" }
      icon { "🏥" }
    end
  end
end
