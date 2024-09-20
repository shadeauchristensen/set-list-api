require 'rails_helper'

RSpec.describe "User registration form" do
  it "creates new user" do
    visit root_path

    save_and_open_page

    click_on "Register as a User"

    expect(current_path).to eq(new_user_path)

    email = "funbucket13@example.com"
    password = "test"

    fill_in :user_email, with: email
    fill_in :user_password, with: password

    click_on "Create User"

    new_user = User.last

    expect(page).to have_content("API Token: #{new_user.api_token}")
  end
end
