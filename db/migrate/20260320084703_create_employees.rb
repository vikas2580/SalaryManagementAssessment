class CreateEmployees < ActiveRecord::Migration[7.2]
  def change
    create_table :employees do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :department
      t.decimal :salary, precision: 10, scale: 2, default: 0.0
      
      t.timestamps
    end
    add_index :employees, :email, unique: true
  end
end
