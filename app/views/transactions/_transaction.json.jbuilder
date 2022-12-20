json.extract! transaction, :id, :note, :my_note, :variable_symbol, :amount, :sender_id, :recipient_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
