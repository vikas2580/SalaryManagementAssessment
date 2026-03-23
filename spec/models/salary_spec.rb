require 'rails_helper'

RSpec.describe Salary, type: :model do
   let(:employee) { create(:employee) }

   it "calculates total correctly" do
    salary = Salary.create(
      employee: employee,
      base_salary: 50000,
      bonus: 5000,
      deduction: 2000
    )
  end
   it "is invalid without base_salary" do
    salary = build(:salary, base_salary: nil, employee: employee)
    expect(salary).not_to be_valid
  end
end
