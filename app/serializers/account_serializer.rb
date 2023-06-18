class AccountSerializer < ActiveModel::Serializer
  attributes :id, :name, :currency, :usr_id, :value
  has_many :expenses, class_name: 'Transaction', foreign_key: 'sender_id'
  has_many :incomes, class_name: 'Transaction', foreign_key: 'recipient_id'
end
