FactoryBot.define do
  factory :salary do
    association :employee
    base_salary { 50000 }
    bonus { 5000 }
    deduction { 2000 }
  end
end
