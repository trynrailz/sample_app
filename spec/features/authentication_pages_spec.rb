require "spec_helper"

feature "Authentication" do
  before { visit signin_path }

  scenario "user visits the sign in page" do
      expect(page).to have_selector('h1', 'Sign in')
      expect(page).to have_title('Sign in')
  end

end

feature "Authentication" do

  before { visit signin_path }
  let(:submit) {"Sign in"}

  scenario "user signs in with invalid info" do
    click_button submit
    expect(page).to have_title('Sign in')
  end

  let(:submit) {"Sign in"}
  let(:user) { FactoryGirl.create(:user) }

  before { visit signin_path }

  scenario "user signs in with valid info" do
    fill_in "Email",        with: user.email 
    fill_in "Password",     with: user.password
    click_button submit 
    expect(page).to have_title(user.name)
    expect(page).to have_link('Users', href:users_path)
    expect(page).to have_link('Profile', href:users_path(user))
    expect(page).to have_link('Settings', href:edit_users_path(user))
    expect(page).to have_link('Sign out', href:signout_path)
  end

  let(:submit) {"Sign in"}
  let(:user) { FactoryGirl.create(:user) }

  before { visit signin_path }

  scenario "user signs out" do
    fill_in "Email",        with: user.email 
    fill_in "Password",     with: user.password
    click_button submit 

    click_link "Sign out"
    expect(page).to have_link('Sign in')
  end

  feature "Authorization" do
    let(:user) {FactoryGirl.create(:user)}

    before { visit edit_user_path }
    scenario "in the user controller" do
      expect(page).to have_selector('title', 'Sign in')
    end

    before { put user_path(user) }
    scenario "submitting to the update action" do
      expect(response).to redirect_to(signin_path)
    end

    let(:user) {FactoryGirl.create(:user)}
    scenario "for non-signed in user" do
      fill_in "Email",        with: user.email 
      fill_in "Password",     with: user.password
      click_button submit 

      expect(page).to have_selector('title', text:'Edit user')
    end

    scenario "for non-signed in user visiting the user index" do
      before { visit users_path}
      expect(page).to have_selector('title', text:'Sign in')
    end
  end

end
