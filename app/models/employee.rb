class Employee < ApplicationRecord
  has_many :salaries, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :department, presence: true
  validates :salary,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  before_save :downcase_email

  private

  def downcase_email
    self.email = email.downcase
  end
end
