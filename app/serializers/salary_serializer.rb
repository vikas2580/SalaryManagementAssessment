class SalarySerializer < ActiveModel::Serializer
  attributes :id, :base_salary, :bonus, :deduction, :total_salary, :employee_id
end
