class Account < ApplicationRecord
  belongs_to :user

  def currency_set
    [["Czech crown", "CZK"], ["Euro", "EUR"], ["US dollar", "USD"]]
  end
end