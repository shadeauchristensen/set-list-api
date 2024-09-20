class User < ApplicationRecord
    has_secure_password

    before_create :generate_api_token

    validates :email, presence: true, uniqueness: true

    private

    def generate_api_token
        self.api_token = SecureRandom.hex(20)
    end
end
