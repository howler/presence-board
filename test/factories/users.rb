FactoryBot.define do
  factory :user do
    name { "John Doe" }
    email { "john@example.com" }
    password { "password" }
    password_confirmation { "password" }
    role { "user" }
    association :department, factory: :department
    association :current_status, factory: :status

    trait :admin do
      name { "Admin User" }
      email { "admin@example.com" }
      role { "admin" }
    end

    trait :jane do
      name { "Jane Smith" }
      email { "jane@example.com" }
      association :department, factory: [:department, :sales]
      association :current_status, factory: [:status, :out]
    end

    trait :bob do
      name { "Bob Johnson" }
      email { "bob@example.com" }
      association :current_status, factory: [:status, :meeting]
    end

    trait :with_note do
      current_note { "Working from office" }
    end
  end
end
