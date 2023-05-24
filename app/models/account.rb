# frozen_string_literal: true

class Account < ApplicationRecord
  require 'csv'

  belongs_to :usr
  has_many :expenses, class_name: 'Transaction', foreign_key: 'sender_id'
  has_many :incomes, class_name: 'Transaction', foreign_key: 'recipient_id'
  has_one_attached :donate_qr_code, dependent: :destroy
  before_commit :generate_donate_qr_code

  validates :name, presence: true
  @busy = false

  def to_csv
    CSV.generate(col_sep: ',') do |csv|
      csv << %w[note amount sender_id recipient_id date] # set column names
      self.history.each do |t|
        csv << [t.note, t.amount, t.sender.id, t.recipient.id, t.created_at.to_s]
      end
    end
  end

  def currency_set
    [['Czech crown', 'CZK', 'Kč'], ['Euro', 'EUR', '€'], ['US dollar', 'USD', '$']]
  end

  def currency_set_form
    [['Czech crown', 'CZK'], ['Euro', 'EUR'], ['US dollar', 'USD']]
  end

  def form
    ["#{id} - #{name}", id.to_s]
  end

  def currency_symbol
    currency_set.each do |cur|
      return cur[2] if cur[1] == currency
    end
    nil
  end

  def value_currency
    "#{value} #{currency_symbol}"
  end

  def history
    expenses + incomes
  end

  def sender?(transaction)
    id == transaction.sender.id
  end

  def recipient?(transaction)
    id == transaction.recipient.id
  end

  def is_busy
    busy || @busy
  end

  def set_busy(value)
    @busy = value
    update(busy: value)
  end
  def generate_donate_qr_code
    donate_link = Rails.application.routes.url_helpers.new_transaction_path(percipient: self.id, note: 'Donate to ' + self.usr.full_name)
    qrcode = RQRCode::QRCode.new(donate_link)

    png = qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: "black",
      file: nil,
      fill: "white",
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 120
    )

    self.donate_qr_code.attach(
      io: StringIO.new(png.to_s),
      filename: "qrcode.png",
      content_type: "image/png"
    )
  end
end
