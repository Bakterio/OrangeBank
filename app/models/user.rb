class User < ApplicationRecord
    has_secure_password # external gem, checks for password match, hashs the password
end
