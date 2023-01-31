class Account < ApplicationRecord
  belongs_to :usr
  has_many :expenses, class_name: "Transaction", foreign_key: "sender_id"
  has_many :incomes, class_name: "Transaction", foreign_key: "recipient_id"

  validates :name, presence: true
  @busy = false

  def currency_set
    [["Czech crown", "CZK", "Kč"], ["Euro", "EUR", "€"], ["US dollar", "USD", "$"]]
  end

  def currency_set_form
    [["Czech crown", "CZK"], ["Euro", "EUR"], ["US dollar", "USD"]]
  end

  def form
    [self.id.to_s + " - " + self.name, self.id.to_s]
  end

  def currency_symbol
    for cur in currency_set
      if cur[1] == self.currency
        return cur[2]
      end
    end
    nil
  end
  
  def value_currency
    self.value.to_s + " " + self.currency_symbol
  end

  def history
    self.expenses + self.incomes
  end

  def sender?(transaction)
    self.id == transaction.sender.id
  end

  def is_busy
    self.busy || @busy
  end

  def set_busy(value)
    @busy = value
    self.update(busy: value)
  end
end