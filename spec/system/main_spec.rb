require "rails_helper"

RSpec.describe "Checks if a User is logged in before accessing the main dashboard", type: :system do
  let(:user) { FactoryBot.create(:user) }

  it "redirects to the login page if the user is not logged in" do
    visit main_dashboard_path
    expect(page).to have_current_path(new_user_session_path)
  end

  it "allows a logged in user to access the main dashboard" do
    login_as(user)
    visit main_dashboard_path
    expect(page).to have_current_path(main_dashboard_path)
  end
end
