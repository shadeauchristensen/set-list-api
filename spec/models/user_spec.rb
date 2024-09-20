require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { described_class.new(email: "user@example.com", password: "password123") }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    it "is not valid without an email" do
      user.email = nil
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is not valid with a duplicate email" do
      described_class.create!(email: "user@example.com", password: "password123")
      duplicate_user = described_class.new(email: "user@example.com", password: "password456")
      expect(duplicate_user).to_not be_valid
      expect(duplicate_user.errors[:email]).to include("has already been taken")
    end
  end

  describe "password encryption" do
    it "authenticates with the correct password" do
      user.save!
      expect(user.authenticate("password123")).to be_truthy
    end

    it "does not authenticate with an incorrect password" do
      user.save!
      expect(user.authenticate("wrongpassword")).to be_falsey
    end
  end

  describe "API token generation" do
    it "generates a unique API token before user creation" do
      expect(user.api_token).to be_nil
      user.save!
      expect(user.api_token).to_not be_nil
      expect(user.api_token.length).to eq(40)
    end
  end
end

