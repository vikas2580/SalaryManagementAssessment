class Api::V1::SalariesController < ApplicationController
  before_action :set_salary, only: [ :show, :update, :destroy ]

  def index
    salaries = Salary.all
     render json: salaries, each_serializer: SalarySerializer
  end

  def show
    render json: @salary, serializer: SalarySerializer
  end

  def create
    salary = Salary.new(salary_params)

    if salary.save
       render json: salary, serializer: SalarySerializer, status: :created
    else
      render json: { errors: salary.errors.full_messages }, status: :unprocessable_content
    end
  end

  def update
    if @salary.update(salary_params)
       render json: @salary, serializer: SalarySerializer
    else
      render json: { errors: @salary.errors.full_messages }, status: :unprocessable_content
    end
  end

  def destroy
    @salary.destroy
     render json: { message: "Salary deleted successfully" }
  end

  private

  def set_salary
    @salary = Salary.find(params[:id])
  end

  def salary_params
    params.require(:salary).permit(:employee_id, :base_salary, :bonus, :deduction)
  end
end
