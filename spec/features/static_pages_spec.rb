require "spec_helper"

feature "Static pages" do
  scenario "Home page" do
      visit '/static_pages/home'
      expect(page).to have_title('Ruby on Rails Tutorial Sample App | Home')
  end

  scenario "Home page" do
      visit '/static_pages/home'
      expect(page).to have_selector('h1', :text => 'Sample App')
  end
end

feature "Static pages" do
  scenario "Help page" do
      visit '/static_pages/help'
      expect(page).to have_title('Ruby on Rails Tutorial Sample App | Help')
  end

  scenario "Help page" do
      visit '/static_pages/help'
      expect(page).to have_selector('h1', 'Help')
  end
end

feature "Static pages" do
  scenario "About page" do
      visit '/static_pages/about'
      expect(page).to have_title('Ruby on Rails Tutorial Sample App | About')
  end

  scenario "About page" do
      visit '/static_pages/about'
      expect(page).to have_selector('h1', 'About Us')
  end
end