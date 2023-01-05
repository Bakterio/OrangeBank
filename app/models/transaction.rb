class Transaction < ApplicationRecord
  belongs_to :sender, class_name: "Account", foreign_key: "sender_id"
  belongs_to :recipient, class_name: "Account", foreign_key: "recipient_id"

  validates :amount, presence: true, format: { with: /\d+[.]\d{1,2}/, message: "format is invalid" }
  validates :note, presence: true

  def commit
    if sender.value < self.amount
      return false
    end

    exchanged_amount = self.exchange

    sender.value -= self.amount
    recipient.value += exchanged_amount
    sender.save!
    recipient.save!
    true
  end

  def display_note
    unless self.my_note == "" or nil
      return self.my_note
    end
    return self.note
  end

  def read_json
    file = File.open "currency_exchange.json"
    JSON.load file
  end

  private
  def exchange
    if sender.currency == recipient.currency
      return self.amount
    end

    amount_in_eur = self.amount / self.read_json["EUR/" + self.sender.currency.to_s].to_f
    return amount_in_eur * self.read_json["EUR/" + self.recipient.currency.to_s].to_f
  end
end
