class Salary < ApplicationRecord
  belongs_to :employee

  before_save :calculate_total

  validates :base_salary, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def calculate_total
    self.total_salary = (base_salary || 0) + (bonus || 0) - (deduction || 0)
  end
end