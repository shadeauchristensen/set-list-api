require 'rails_helper'

RSpec.describe "Retrieving API Token" do
  it "can log in with valid credentials" do
    user = User.create(email: "funbucket13@example.com", password: "test", api_token: "987654321")

    visit root_path

    click_on "I already have an account"

    expect(current_path).to eq(users_login_path)

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on "Get API Token"

    expect(page).to have_content("API Token: #{user.api_token}")
  end
end