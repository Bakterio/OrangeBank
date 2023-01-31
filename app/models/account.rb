class Account < ApplicationRecord
  belongs_to :usr
  has_many :expenses, class_name: 'Transaction', foreign_key: 'sender_id'
  has_many :incomes, class_name: 'Transaction', foreign_key: 'recipient_id'

  validates :name, presence: true
  @busy = false

  def currency_set
    [['Czech crown', 'CZK', 'Kč'], ['Euro', 'EUR', '€'], ['US dollar', 'USD', '$']]
  end

  def currency_set_form
    [['Czech crown', 'CZK'], ['Euro', 'EUR'], ['US dollar', 'USD']]
  end

  def form
    [id.to_s + ' - ' + name, id.to_s]
  end

  def currency_symbol
    for cur in currency_set
      return cur[2] if cur[1] == currency
    end
    nil
  end

  def value_currency
    value.to_s + ' ' + currency_symbol
  end

  def history
    expenses + incomes
  end

  def sender?(transaction)
    id == transaction.sender.id
  end

  def is_busy
    busy || @busy
  end

  def set_busy(value)
    @busy = value
    update(busy: value)
  end
end
