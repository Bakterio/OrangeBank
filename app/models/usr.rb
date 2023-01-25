class Usr < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :accounts
  def full_name
    self.first_name + " " + self.last_name
  end

  def accounts_set
    out = []
    self.accounts.each { |account|
      out.push account.name
    }
    return out
  end

  def accounts_form_set
    output = []
    self.accounts.each { |account|
      output.append(account.form)
    }
    output
  end

  def all_accounts_value_eur
    value = 0
    self.accounts.each { |account|
      value += account.value / Transaction.new.read_json["EUR/" + account.currency.to_s].to_f
    }
    return value.round(2)
  end
end
