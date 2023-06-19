module AccountsHelper
  def value_in_all_currencies(account)
    out = ""
    separator = " <i>or</i> "
    Account.currency_set.each do |set|
      out += current_usr.all_accounts_value(set[1]).to_s. + " " + Account.currency_symbol_from_code(set[1]) + separator
    end
    out.delete_suffix(separator).html_safe
  end
end
