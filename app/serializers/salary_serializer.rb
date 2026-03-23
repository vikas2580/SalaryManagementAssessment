class SalarySerializer < ActiveModel::Serializer
  attributes :id, :base_salary, :bonus, :deduction, :total_salary, :employee_id

  def total_salary
    object.total_salary.to_f
  end
end
