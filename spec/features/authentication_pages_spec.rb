require "spec_helper"

feature "Authentication" do
  before { visit signin_path }

  scenario "signin page" do
      expect(page).to have_selector('h1', 'Sign in')
      expect(page).to have_title('Sign in')
  end

end

feature "Authentication" do

  before { visit signin_path }
  let(:submit) {"Sign in"}

  scenario "signin with invalid info" do
    click_button submit
    expect(page).to have_title('Sign in')
  end

end

feature "Authentication" do

  let(:submit) {"Sign in"}
  let(:user) { FactoryGirl.create(:user) }

  before { visit signin_path }

  scenario "sign in with valid info" do
    fill_in "Email",        with: user.email 
    fill_in "Password",     with: user.password
    click_button submit 
    expect(page).to have_title(user.name)
  end

  scenario "sign out" do
    click_link "Sign out"
    expect(page).to have_link('Sign in')
  end

end
