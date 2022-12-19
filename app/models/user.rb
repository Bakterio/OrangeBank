class User < ApplicationRecord
    has_secure_password # external gem, checks for password match, hashs the password

    validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "not an email adress" }# before is user saved
    validates :password_digest, presence: true
end
