# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :sender, class_name: 'Account', foreign_key: 'sender_id'
  belongs_to :recipient, class_name: 'Account', foreign_key: 'recipient_id'

  validates :amount, presence: true, numericality: { greater_than: 0, less_than: 1_000_000 },
                     format: { with: /\A\d+[.]\d{1,2}\z/, message: 'format is invalid' }
  validates :note, presence: true

  def commit
    return false if sender.value < amount

    transaction do
      sender.update!(value: sender.value - amount)
      recipient.update!(value: recipient.value + exchange)
      save!
    end
    true
  end

  def display_note
    return my_note unless (my_note == '') || nil

    note
  end

  def read_json
    File.open 'currency_exchange.json' do |file|
      JSON.parse file.read
    end
  end

  private

  def exchange
    return amount if sender.currency == recipient.currency

    amount_in_eur = amount / read_json["EUR/#{sender.currency}"]
    amount_in_eur * read_json["EUR/#{recipient.currency}"]
  end
end
