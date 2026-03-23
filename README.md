# Salary Management API

# Features
- Employee CRUD APIs
- Salary CRUD APIs
- Automatic salary calculation (base + bonus - deduction)
- RSpec tests using TDD approach
- GitHub Actions CI

# Business Logic
Salary is calculated as:
total_salary = base_salary + bonus - deduction

#Tech Stack
- Ruby on Rails
- PostgreSQL
- RSpec
- ActiveModelSerializers

## 📦 Setup

```bash
bundle install
rails db:create db:migrate
rails s
