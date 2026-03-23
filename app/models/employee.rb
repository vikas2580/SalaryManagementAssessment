class Employee < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  has_many :salaries, dependent: :destroy
end
