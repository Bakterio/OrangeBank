class Usr < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :accounts
  def full_name
    first_name + ' ' + last_name
  end

  def accounts_set
    out = []
    accounts.each do |account|
      out.push account.name
    end
    out
  end

  def accounts_form_set
    output = []
    accounts.each do |account|
      output.append(account.form)
    end
    output
  end

  def all_accounts_value_eur
    value = 0
    accounts.each do |account|
      value += account.value / Transaction.new.read_json['EUR/' + account.currency.to_s].to_f
    end
    value.round(2)
  end
end
