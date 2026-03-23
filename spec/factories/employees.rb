FactoryBot.define do
  factory :employee do
    name { "Vikas" }
    sequence(:email) { |n| "vikas#{n}@test.com" }
    department { "IT" }
    salary { 50000 }
  end
end