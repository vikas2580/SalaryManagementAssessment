require 'rails_helper'

RSpec.describe Employee, type: :model do
  subject { build(:employee) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is invalid without name" do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it "is invalid if name is too short" do
    subject.name = "A"
    expect(subject).not_to be_valid
  end

  it "is invalid without email" do
    subject.email = nil
    expect(subject).not_to be_valid
  end

  it "is invalid with wrong email format" do
    subject.email = "invalid_email"
    expect(subject).not_to be_valid
  end

  it "does not allow duplicate email" do
    create(:employee, email: subject.email)
    expect(subject).not_to be_valid
  end

  it "is invalid without department" do
    subject.department = nil
    expect(subject).not_to be_valid
  end

  it "is invalid without salary" do
    subject.salary = nil
    expect(subject).not_to be_valid
  end

  it "is invalid with negative salary" do
    subject.salary = -100
    expect(subject).not_to be_valid
  end

  it "downcases email before saving" do
    emp = create(:employee, email: "TEST@MAIL.COM")
    expect(emp.email).to eq("test@mail.com")
  end

  it "has many salaries" do
    association = Employee.reflect_on_association(:salaries)
    expect(association.macro).to eq(:has_many)
  end
end