require 'rails_helper'

RSpec.describe "UserAuth", type: :request do

  context "when not logged in" do
    describe "GET /sign_in" do
      it "returns http success" do
        get "/users/sign_in"
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET /sign_up" do
      it "returns http success" do
        get "/users/sign_up"
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET /password/new" do
      it "returns http success" do
        get "/users/password/new"
        expect(response).to have_http_status(:success)
      end
    end
  end
end