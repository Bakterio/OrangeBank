class TransactionsSerializer < ActiveModel::Serializer
  attributes :id, :note, :variable_symbol, :amount, :sender_id, :recipient_id, :created_at
  belongs_to :account
end
