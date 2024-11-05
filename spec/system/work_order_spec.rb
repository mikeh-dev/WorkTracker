require "rails_helper"

RSpec.describe "Work Order", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:work_order) { FactoryBot.create(:work_order, :repair, user: user) }

  context "when not logged in" do
    it "does not allow access to the work order index page" do
      visit work_orders_path
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end

    it "does not allow access to the work order new page" do
      visit new_work_order_path
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end

    it "does not allow access to the work order show page" do
      visit work_order_path(work_order)
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end

    it "does not allow access to the work order edit page" do
      visit edit_work_order_path(work_order)
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end 
  end

  context "when logged in" do
    before do
      sign_in user
    end
  end
end
