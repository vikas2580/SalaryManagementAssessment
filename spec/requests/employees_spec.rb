require 'rails_helper'

RSpec.describe "Employees API", type: :request do
  let!(:employees) { create_list(:employee, 3) }
  let(:employee_id) { employees.first.id }

  describe "GET /api/v1/employees" do
    it "returns all employees" do
      get "/api/v1/employees"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(json.length).to eq(3)
    end
  end

  describe "GET /api/v1/employees/:id" do
    it "returns employee" do
      get "/api/v1/employees/#{employee_id}"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json["id"]).to eq(employee_id)
    end

    it "returns not found" do
      get "/api/v1/employees/999"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /api/v1/employees" do
    let(:valid_params) do
      {
        employee: {
          name: "Test",
          email: "test@test.com",
          department: "HR",
          salary: 40000
        }
      }
    end

    it "creates employee" do
      post "/api/v1/employees", params: valid_params

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)

      expect(json["name"]).to eq("Test")
    end

    it "returns validation error" do
      post "/api/v1/employees", params: { employee: { name: "" } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PUT /api/v1/employees/:id" do
    it "updates employee" do
      put "/api/v1/employees/#{employee_id}", params: {
        employee: { name: "Updated" }
      }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json["name"]).to eq("Updated")
    end
  end

  describe "DELETE /api/v1/employees/:id" do
    it "deletes employee" do
      delete "/api/v1/employees/#{employee_id}"

      expect(response).to have_http_status(:ok)
    end
  end
end
