class Api::V1::EmployeesController < ApplicationController
  before_action :set_employee, only: [ :show, :update, :destroy ]

  def index
    employees = Employee.all
    render json: {
      status: "success",
      data: ActiveModelSerializers::SerializableResource.new(employees)
    }
  end

  def show
    render json: {
      status: "success",
      data: ActiveModelSerializers::SerializableResource.new(@employee)
    }
  end

  def create
    employee = Employee.new(employee_params)
    if employee.save
      render json: {
        status: "success",
        message: "Employee created successfully",
        data: ActiveModelSerializers::SerializableResource.new(employee)
      }, status: :created
    else
      render json: {
        status: "error",
        errors: employee.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    if @employee.update(employee_params)
      render json: {
        status: "success",
        message: "Employee updated successfully",
        data: ActiveModelSerializers::SerializableResource.new(@employee)
      }
    else
      render json: {
        status: "error",
        errors: @employee.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy
    render json: {
      status: "success",
      message: "Employee deleted successfully"
    }
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { status: "error", message: "Employee not found" }, status: :not_found
  end

  def employee_params
      params.require(:employee).permit(:name, :email, :department, :salary)
  end
end
