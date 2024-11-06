require "rails_helper"

RSpec.describe "User authentication", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:work_order) { FactoryBot.create(:work_order, user: user) }
  
  context "when not logged in" do
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

    it "allows a user to request a password reset when forgotten" do
      visit root_path
      expect(page).to have_content("Sign in")
      click_link "Forgot your password?"
      expect(page).to have_content("Forget your password?")
      visit new_user_password_path
      fill_in "Email", with: user.email
      click_button "Send me reset password instructions"
        expect(page).to have_content("You will receive an email with instructions on how to reset your password in a few minutes.")
    end

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

    it "allows a user to log out" do
      visit root_path
      find('#dropdowns-nav-toggle').click
      click_button "Sign out"
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end

    it "allows a User to view work orders index page" do
      visit work_orders_path
      expect(page).to have_content("Work Orders")
      expect(page).to have_current_path(work_orders_path)
    end

    it "allows a User to view work orders new page" do
      visit new_work_order_path
      expect(page).to have_content("New Work Order")
      expect(page).to have_current_path(new_work_order_path)
    end

    it "allows a User to view work orders show page" do
      visit work_order_path(work_order)
      expect(page).to have_content(work_order.customer_name)
      expect(page).to have_current_path(work_order_path(work_order))
    end

    it "does not allow a User to view work orders edit page" do
      visit edit_work_order_path(work_order)
      expect(page).to have_content("You are not authorized to access this page.")
    end
  end
end