class Api::V1::EmployeesController < ApplicationController
  before_action :set_employee, only: [ :show, :update, :destroy ]

  def index
    employees = Employee.all
    render json: employees, each_serializer: EmployeeSerializer
  end

  def show
    render json: @employee, serializer: EmployeeSerializer
  end
  

  def create
    employee = Employee.new(employee_params)
    if employee.save
    render json: employee, serializer: EmployeeSerializer, status: :created
    else
      render json: { errors: employee.errors.full_messages }, status: :unprocessable_content
    end
  end

  def update
    if @employee.update(employee_params)
      render json: @employee, serializer: EmployeeSerializer
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_content
    end
  end

  def destroy
    @employee.destroy
    render json: { message: "Employee deleted successfully" }
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
      params.require(:employee).permit(:name, :email, :department, :salary)
  end
end
