class Account < ApplicationRecord
  belongs_to :user
  has_many :expenses, class_name: "Transaction", foreign_key: "sender_id"
  has_many :incomes, class_name: "Transaction", foreign_key: "recipient_id"

  validates :name, presence: true

  def currency_set
    [["Czech crown", "CZK", "Kč"], ["Euro", "EUR", "€"], ["US dollar", "USD", "$"]]
  end

  def currency_symbol
    for cur in currency_set
      if cur[1] == self.currency
        return cur[2]
      end
    end
    nil
  end
end