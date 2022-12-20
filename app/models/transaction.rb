class Transaction < ApplicationRecord
  belongs_to :sender, class_name: "Account", foreign_key: "sender_id"
  belongs_to :recipient, class_name: "Account", foreign_key: "recipient_id"

  validates :amount, presence: true, format: { with: /\d+[.]\d{2}/, message: "format is invalid" } # FIXME .00 not working
  validates :note, presence: true
end
