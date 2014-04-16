feature "Static pages" do
  before { visit signup_path }
  scenario "Signup page" do
      expect(page).to have_selector('h1', 'Sign up')
  end
end