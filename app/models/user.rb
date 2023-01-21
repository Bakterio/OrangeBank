class User < ApplicationRecord
    has_secure_password # external gem, checks for password match, hashes the password

    validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "not an email address" }# before is user saved
    validates :password_digest, presence: true

    has_many :accounts

    def full_name
        self.first_name + " " + self.last_name
    end

    def accounts_set
        out = []
        self.accounts.each { |account|
            out.push account.name
        }
        return out
    end

    def accounts_form_set
        output = []
        self.accounts.each { |account|
            output += account.form
        }
        output
    end

    def all_accounts_value_eur
        value = 0
        self.accounts.each { |account|
            value += account.value / Transaction.new.read_json["EUR/" + account.currency.to_s].to_f
        }
        return value.round(2)
    end
end
