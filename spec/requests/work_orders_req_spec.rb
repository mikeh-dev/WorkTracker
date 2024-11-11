require 'rails_helper'

RSpec.describe "WorkOrders", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:work_order) { FactoryBot.create(:work_order, user: user) }

  context "when user is logged in" do
    before do
      sign_in user
    end

    describe "GET /index" do
      it "returns http success" do
        get work_orders_path
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET /new" do
      it "returns http success" do
        get new_work_order_path
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET /edit" do
      it "returns http success" do
        get edit_work_order_path(work_order)
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET /show" do
      it "returns http success" do
        get work_order_path(work_order)
        expect(response).to have_http_status(:success)
      end
    end

    describe "POST /create" do
      let(:valid_attributes) {
        { work_order: FactoryBot.attributes_for(:work_order, user: user) }
      }

      it "creates a new work order and redirects to the show page" do
        expect {
          post work_orders_path, params: valid_attributes
        }.to change(WorkOrder, :count).by(1)
        expect(response).to redirect_to(work_orders_path)
      end

      it "creates a work order with correct attributes" do
        post work_orders_path, params: valid_attributes
        
        work_order = WorkOrder.last
        expect(work_order.production_job_number).to eq(valid_attributes[:work_order][:production_job_number])
        expect(work_order.job_type.to_sym).to eq(valid_attributes[:work_order][:job_type].to_sym)
        expect(work_order.user).to eq(user)
      end

      context "with invalid attributes" do
        let(:invalid_attributes) {
          { work_order: FactoryBot.attributes_for(:work_order, customer_name: nil) }
        }

        it "does not create a work order" do
          expect {
            post work_orders_path, params: invalid_attributes
          }.not_to change(WorkOrder, :count)
        end

        it "returns unprocessable entity status" do
          post work_orders_path, params: invalid_attributes
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe "PATCH /update" do
      let(:update_attributes) { { work_order: { customer_name: "Updated Name" } } }

      it "updates the work order and redirects to the show page" do
        patch work_order_path(work_order), params: update_attributes
        work_order.reload
        expect(work_order.customer_name).to eq("Updated Name")
        expect(response).to redirect_to(edit_work_order_path(work_order))
      end
    end

    describe "DELETE /destroy" do
      it "deletes the work order and redirects to index" do
        delete work_order_path(work_order)
        expect(response).to redirect_to(work_orders_path)
        expect(WorkOrder.exists?(work_order.id)).to be_falsey
      end
    end
  end

  context "when not logged in" do
    describe "GET /index" do
      it "redirects to the login page" do
        get work_orders_path
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET /new" do
      it "redirects to the login page" do
        get new_work_order_path
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET /edit" do
      it "redirects to the login page" do
        get edit_work_order_path(work_order)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET /show" do
      it "redirects to the login page" do
        get work_order_path(work_order)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end