require "rails_helper"

RSpec.describe "Checks if a User is logged in before accessing the main dashboard", type: :system do
  let(:user) { FactoryBot.create(:user) }

  it "redirects to the login page if the user is not logged in" do
    visit root_path
    expect(page).to have_current_path(new_user_session_path)
  end

  it "allows a logged in user to access the main dashboard" do
    sign_in user
    visit root_path
    expect(page).to have_current_path(root_path)
  end
end
