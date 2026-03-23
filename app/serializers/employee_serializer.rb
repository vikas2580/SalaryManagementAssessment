class EmployeeSerializer < ActiveModel::Serializer
   attributes :id, :name, :email, :department, :salary, :created_at

   def salary
    object.salary.to_f
  end
end
