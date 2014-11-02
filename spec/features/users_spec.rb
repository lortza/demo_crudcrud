# spec/features/users_spec.rb
require 'rails_helper'

# `feature` is an alias for `describe`
feature 'User accounts' do
  before do
    # go to the home page
    visit root_path
  end

  # `scenario` is an alias for `it`
  scenario "add a new user" do

    # go to the signup page
    click_link "New User"

    # fill in the form for a new user
    name = "Foo"
    fill_in "Name", with: name
    fill_in "Email", with: "foo@bar.com"
    fill_in "Password", with: "foobarfoobar"
    fill_in "Password confirmation", with: "foobarfoobar"

    # submit the form and verify it created a user
    expect{ click_button "Create User" }.to change(User, :count).by(1)

    # verify that we've been redirected to that user's page
    expect(page).to have_content "user show for #{name}"

    # verify the flash is working properly
    expect(page).to have_content "Created new user!"    

  end
  #...and so on
end

feature 'Authentication' do
  let(:user){ create(:user) }
  before do
    visit login_path
  end

  context "with improper credentials" do
    before do
      user.email = user.email + "x"
      sign_in(user)
    end

    scenario "does not allow sign in" do
      expect(page).to have_content "We couldn't sign you in"
    end
  end

  context "with proper credentials" do
    before do
      sign_in(user)
    end
    scenario "successfully signs in an existing user" do
      # verify we're on the user's show page now
      expect(page).to have_content "You've successfully signed in"
    end

    context "after signing out" do
      before do
        sign_out
      end
      scenario "signs out the user" do
        expect(page).to have_content "You've successfully signed out"
      end
    end
  end
end