require 'rails_helper'

RSpec.describe "WorkOrders", type: :request do
  let(:user) { FactoryBot.create(:user) }

  context "when not logged in" do

    before do
      sign_in user
    end
    describe "GET /index" do
      it "returns http success" do
        get "/work_orders/index"
        expect(response).to have_http_status(:success)
      end
    end
  
    describe "GET /new" do
      it "returns http success" do
        get "/work_orders/new"
        expect(response).to have_http_status(:success)
      end
    end
  
    describe "GET /edit" do
      it "returns http success" do
        get "/work_orders/edit"
        expect(response).to have_http_status(:success)
      end
    end
  
    describe "GET /show" do
      it "returns http success" do
        get "/work_orders/show"
        expect(response).to have_http_status(:success)
      end
    end
  end

  context "when not logged in" do

    describe "GET /index" do
      it "returns http redirect" do
        get "/work_orders/index"
        expect(response).to have_http_status(:redirect)
      end
    end
  
    describe "GET /new" do
      it "returns http redirect" do
        get "/work_orders/new"
        expect(response).to have_http_status(:redirect)
      end
    end
  
    describe "GET /edit" do
      it "returns http redirect" do
        get "/work_orders/edit"
        expect(response).to have_http_status(:redirect)
      end
    end
  
    describe "GET /show" do
      it "returns http redirect" do
        get "/work_orders/show"
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end