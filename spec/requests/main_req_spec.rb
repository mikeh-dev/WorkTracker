require 'rails_helper'

RSpec.describe "Main", type: :request do
  let(:user) { FactoryBot.create(:user) }
  context "when not logged in" do
    describe "GET /" do
      it "returns http redirect" do
        get "/"
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  context "when logged in" do
    before do
      sign_in user
    end

    describe "GET /" do
      it "returns http success" do
        get "/"
        expect(response).to have_http_status(:success)
      end
    end
  end
end