require "rails_helper"

RSpec.describe "User authentication", type: :system do
  let(:user) { FactoryBot.create(:user) }

  it "allows a user to sign up" do
    visit new_user_registration_path
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"
    expect(page).to have_content("Welcome! You have signed up successfully.")
  end

  it "does not allow a user to sign up with invalid credentials" do
    visit new_user_registration_path
    click_button "Sign up"
    expect(page).to have_content("Email can't be blank")
    visit new_user_registration_path
    fill_in "Email", with: "test@example.com"
    click_button "Sign up"
    expect(page).to have_content("Password can't be blank")
  end

  it "allows a user to log in with valid credentials" do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
    expect(page).to have_content("Signed in successfully.")
  end

  it "does not allow a user to log in with invalid credentials" do
    visit new_user_session_path
    fill_in "Email", with: "invalid@example.com"
    fill_in "Password", with: "invalidpassword"
    click_button "Sign in"
    expect(page).to have_content("Invalid Email or password.")
  end

  it "allows a user to log out" do
    login_as(user)
    visit main_dashboard_path
    find('#dropdowns-nav-toggle').click
    click_button "Sign out"
    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end

  it "allows a user to reset their password" do
    visit new_user_password_path
    fill_in "Email", with: user.email
    click_button "Send me reset password instructions"
    expect(page).to have_content("You will receive an email with instructions on how to reset your password in a few minutes.")
  end
end