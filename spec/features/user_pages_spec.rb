require "spec_helper"

feature "Static pages" do
  before { visit signup_path }
  scenario "Signup page" do
      expect(page).to have_selector('h1', 'Sign up')
  end
end

feature "profile page" do

	let(:user) { FactoryGirl.create(:user) }
	before { visit user_path(user) }

	scenario "profile pages " do
      expect(page).to have_selector('h1', user.name)
      expect(page).to have_title(user.name)
  end

end


feature "signup" do

  before { visit signup_path }
  let(:submit) {"Create my account"}
  
  scenario "with invalid information" do
    expect { click_button submit }.not_to change(User, :count)
  end

  scenario "with valid information" do
  
    fill_in "Name",         with: "Example User"
    fill_in "Email",        with: "user@example.com"
    fill_in "Password",     with: "foobar1"
    fill_in "Confirmation", with: "foobar1"

    expect { click_button submit }.to change(User, :count).by(1)

   end

end
