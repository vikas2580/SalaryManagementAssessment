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
end
