class CreateSalaries < ActiveRecord::Migration[7.2]
  def change
    create_table :salaries do |t|
      t.references :employee, null: false, foreign_key: true
      t.decimal :base_salary
      t.decimal :bonus
      t.decimal :deduction
      t.decimal :total_salary

      t.timestamps
    end
  end
end
