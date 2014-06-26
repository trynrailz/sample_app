require "spec_helper"

feature "User pages" do
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

  scenario "after submission" do
    click_button submit
    expect(page).to have_selector('h1', 'Example User')
   end

end


feature "edit" do
  let(:user) { FactoryGirl.create(:user) }
  before do
    sign_in user
    visit edit_user_path(user)
  end

  scenario "page" do
    expect(page).to have_selector("h1", "Update your profile")
    expect(page).to have_link('change', href: "http://gravatar.com/emails")
  end

  scenario "with invalid information" do
    click_button "Save changes"
    expect(page).to have_content('error') 
  end

  let(:new_name)  { "New Name" }
  let(:new_email) { "new@email.com" }

  scenario "with valid information" do
  
    fill_in "Name",         with: new_name
    fill_in "Email",        with: new_email
    fill_in "Password",     with: user.password
    fill_in "Confirmation", with: user.password_confirmation

    click_button "Save changes" 

    expect(page).to have_link('Sign out', href: signout_path) 

    expect(user.reload.name).to eq(new_name)
    expect(user.reload.email).to eq(new_email)

   end

end

feature "as wrong user" do
  let (:user) {FactoryGirl.create(:user) }
  let (:wrong_user) {FactoryGirl.create(:user, email:"wrong@example.com")}

  before {sign_in user}

  scenario "visiting users edit page" do
    expect(page).not_to have_selector('title', text:full_title('Edit user'))
  end

  scenario "submit a PUT to the Users#update action" do
    before { put user_path(wrong_user) }
    specify { response.should redirect_to(root_path) }
  end

end


feature " index" do
  
  let(:user) = FactoryGirl.create(:user)
  before do
    sign_in user
    visit users_path
  end

  expect(page).to have_selector('title', text: 'All users')
  expect(page).to have_selector('h1', text: 'All users')

  scenaro "should list each user" do
    User.all.each do |user|
      expect(page).to have_selector('li', text:user.name)
    end
  end

  scenario "delete links" do
    expect(page).not_to have_link('delete')
  end

  scenario "as admin user" do
    let (:admin) { FactoryGirl.create(:admin)}
    before do
      sign_in admin
      visit users_path
    end

    expect(page).to have_link('delete', user_path(User.first))

    expect(click_link('delete')).to change(User, :count).by(-1)

    expect(page).not_to have_link('delete', user_path(admin))
  end

end