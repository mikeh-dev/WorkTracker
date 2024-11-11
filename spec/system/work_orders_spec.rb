require 'rails_helper'

RSpec.describe "Work Orders", type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "index page with multiple orders" do
    let!(:upcoming_orders) do
      [
        create(:work_order, :booked, production_job_number: "PJ11111", user: user),
        create(:work_order, :booked, production_job_number: "PJ22222", user: user),
        create(:work_order, :booked, production_job_number: "PJ33333", user: user)
      ]
    end

    let!(:completed_orders) do
      [
        create(:work_order, :completed, production_job_number: "PJ44444", user: user),
        create(:work_order, :completed, production_job_number: "PJ55555", user: user)
      ]
    end

    before { visit work_orders_path }

    it "displays upcoming orders in the default tab" do
      within("#upcoming-work-orders") do
        upcoming_orders.each do |order|
          expect(page).to have_content(order.production_job_number)
          expect(page).to have_content(order.customer_name)
          expect(page).to have_content(order.location)
        end
      end
    end

    it "displays completed orders in the Completed tab" do
      click_link "Completed"
      completed_orders.each do |order|
        expect(page).to have_content(order.production_job_number)
        expect(page).to have_content(order.customer_name)
        expect(page).to have_content(order.location)
      end
    end

    it "displays all orders in the All tab" do
      click_link "All"
      (upcoming_orders + completed_orders).each do |order|
        expect(page).to have_content(order.production_job_number)
        expect(page).to have_content(order.customer_name)
        expect(page).to have_content(order.location)
      end
    end
  end

  describe "create work order page" do
    before { visit new_work_order_path }

    it "displays the create form" do
      expect(page).to have_content("New Work Order")
    end

    it "allows the user to create a new work order" do
      fill_in "Production Job Number", with: "PJ12345"
      fill_in "Sales Order Number", with: "SO12345"
      fill_in "Customer Name", with: "John Doe"
      fill_in "Customer Contact Number", with: "07700900000"
      fill_in "Customer Email", with: "john.doe@example.com"
      select "Liverpool", from: "Location"
      click_button "Save & Back to Work Orders"
      expect(page).to have_content("Work order created successfully")
    end

    it "displays validation errors for missing required fields" do
      click_button "Save & Back to Work Orders"
      expect(page).to have_content("can't be blank")
    end

    it "displays validation error for missing customer name" do
      fill_in "Customer Name", with: ""
      click_button "Save & Back to Work Orders"
      expect(page).to have_content("can't be blank")
    end

    it "limits vehicle registration number to 8 characters" do
      fill_in "Vehicle Registration Number", with: "A" * 9
      click_button "Save & Back to Work Orders"
      expect(page).to have_content("is too long (maximum is 8 characters)")
    end
  end

  describe "edit work order page" do
    let(:work_order) { create(:work_order, user: user) }

    before { visit edit_work_order_path(work_order) }

    it "displays the edit form" do
      expect(page).to have_content("Work Order")
    end

    it "allows the user to update the work order" do
      fill_in "Customer Name", with: "Jane Doe"
      click_button "Save & Back to Work Orders"
      expect(page).to have_content("Work order updated successfully")
    end
  end
end