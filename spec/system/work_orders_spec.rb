require 'rails_helper'

RSpec.describe "Work Orders", type: :system do
  let(:user) { create(:user) }
  
  before do
    sign_in user
  end

  describe "index page" do
    let!(:upcoming_order) { create(:work_order, user: user, start_date: Date.tomorrow, job_type: :repair) }
    let!(:completed_order) { create(:work_order, user: user, start_date: 1.day.ago, job_type: :installation) }
    
    before do
      visit work_orders_path
    end

    it "displays the page title" do
      expect(page).to have_content("Work Orders")
    end

    it "has a create work order button" do
      expect(page).to have_link("Create Work Order")
    end

    describe "tab navigation" do
      it "shows Upcoming tab by default" do
        within("#upcoming-work-orders") do
          expect(page).to have_content(upcoming_order.production_job_number)
        end
      end

      it "can switch to Complete tab" do
        click_link "Complete"
        expect(page).to have_content(completed_order.production_job_number)
      end

      it "can switch to All tab and see all orders" do
        click_link "All"
        expect(page).to have_content(upcoming_order.production_job_number)
        expect(page).to have_content(completed_order.production_job_number)
      end
    end

    describe "work order details" do
      it "displays key information for each order" do
        within("#upcoming-work-orders") do
          expect(page).to have_content(upcoming_order.location)
          expect(page).to have_content(upcoming_order.start_date.strftime("%b %d, %Y"))
          expect(page).to have_content(upcoming_order.job_type.titleize)
        end
      end
    end

    describe "actions dropdown" do
      it "can open the actions menu" do
        find("button", text: "Actions").click
        expect(page).to have_link("Go to Booking")
      end
    end

    describe "pagination" do
      before do
        create_list(:work_order, 12, user: user) # Create enough orders to trigger pagination
      end

      it "shows pagination controls" do
        expect(page).to have_link("Next")
        expect(page).to have_link("Previous")
      end

      it "can navigate between pages" do
        click_link "2"
        expect(page).to have_current_path(/page=2/)
      end
    end
  end
end 