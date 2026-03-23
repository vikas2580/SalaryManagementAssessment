class Api::V1::SalariesController < ApplicationController
  before_action :set_salary, only: [ :show, :update, :destroy ]

  def index
    salaries = Salary.all
    render json: {
      status: "success",
      data: ActiveModelSerializers::SerializableResource.new(salaries)
    }
  end

  def show
    render json: {
      status: "success",
      data: ActiveModelSerializers::SerializableResource.new(@salary)
    }
  end

  def create
    salary = Salary.new(salary_params)

    if salary.save
      render json: {
        status: "success",
        data: ActiveModelSerializers::SerializableResource.new(salary)
      }, status: :created
    else
      render json: {
        status: "error",
        errors: salary.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    if @salary.update(salary_params)
      render json: {
        status: "success",
        data: ActiveModelSerializers::SerializableResource.new(@salary)
      }
    else
      render json: {
        status: "error",
        errors: @salary.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @salary.destroy
    render json: { status: "success", message: "Deleted" }
  end

  private

  def set_salary
    @salary = Salary.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { status: "error", message: "Salary not found" }, status: :not_found
  end

  def salary_params
    params.require(:salary).permit(:employee_id, :base_salary, :bonus, :deduction)
  end
end
