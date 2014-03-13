require "spec_helper"

feature "Static pages" do
  scenario "Home page" do
      visit '/static_pages/home'
      expect(page).to have_text('Sample App')
  end
end
