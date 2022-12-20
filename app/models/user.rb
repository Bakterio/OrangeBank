class User < ApplicationRecord
    has_secure_password # external gem, checks for password match, hashs the password

    validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "not an email adress" }# before is user saved
    validates :password_digest, presence: true

    has_many :accounts

    def full_name
        self.first_name + " " + self.last_name
    end

    def accounts_set
        out = []
        for account in self.accounts
            out.push account.name 
        end
        return out
    end
end
