require 'rails_helper'

RSpec.describe "Salaries API", type: :request do
  let!(:employee) { create(:employee) }
  let!(:salaries) { create_list(:salary, 3, employee: employee) }
  let(:salary_id) { salaries.first.id }

  describe "GET /api/v1/salaries" do
    it "returns all salaries" do
      get "/api/v1/salaries"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json["data"].length).to eq(3)
    end
  end

  describe "GET /api/v1/salaries/:id" do
    it "returns salary" do
      get "/api/v1/salaries/#{salary_id}"

      expect(response).to have_http_status(:ok)
    end

    it "returns not found" do
      get "/api/v1/salaries/999"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /api/v1/salaries" do
    let(:valid_params) do
      {
        salary: {
          employee_id: employee.id,
          base_salary: 40000,
          bonus: 3000,
          deduction: 1000
        }
      }
    end

    it "creates salary and calculates total" do
      post "/api/v1/salaries", params: valid_params

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)

      expect(json["data"]["total_salary"].to_f).to eq(42000)
    end

    it "fails without base_salary" do
      post "/api/v1/salaries", params: { salary: { employee_id: employee.id } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PUT /api/v1/salaries/:id" do
    it "updates salary" do
      put "/api/v1/salaries/#{salary_id}", params: {
        salary: { bonus: 10000 }
      }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json["data"]["total_salary"].to_f).to eq(58000)
    end
  end

  describe "DELETE /api/v1/salaries/:id" do
    it "deletes salary" do
      delete "/api/v1/salaries/#{salary_id}"

      expect(response).to have_http_status(:ok)
    end
  end
end
