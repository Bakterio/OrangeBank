class Transaction < ApplicationRecord
  belongs_to :sender, class_name: "Account", foreign_key: "sender_id"
  belongs_to :recipient, class_name: "Acocunt", foreign_key: "recipient_id"
end
