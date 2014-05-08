require "spec_helper"

feature "Static pages" do
  before { visit root_path }
  scenario "Home page" do   
      expect(page).to have_title('Ruby on Rails Tutorial Sample App')
      expect(page).to have_selector('h1', :text => 'Sample App')
      expect(page).not_to have_title(' | Home')
  end
end

feature "Static pages" do
  before { visit help_path }
  scenario "Help page" do
      expect(page).to have_title('Ruby on Rails Tutorial Sample App | Help')
      expect(page).to have_selector('h1', 'Help')
  end
end

feature "Static pages" do
  before {visit about_path }
  scenario "About page" do
      expect(page).to have_title('Ruby on Rails Tutorial Sample App | About')
      expect(page).to have_selector('h1', 'About Us')
  end
end

feature "Static pages" do
  before { visit contact_path }
  scenario "Contact page" do
      expect(page).to have_title('Ruby on Rails Tutorial Sample App | Contact')
      expect(page).to have_selector('h1', 'Contact')
  end
end

feature "test" do
  subject { page }
  describe "Home Page" do
    before {visit root_path}
    it {should have_selector('h1', text: 'Welcome to the Sample App')}

  end
end

feature "Static pages" do
  before { visit signup_path }
  scenario "Signup page" do
      expect(page).to have_selector('h1', 'Sign up')
  end
end