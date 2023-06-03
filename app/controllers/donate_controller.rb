class DonateController < ApplicationController
  before_action :authenticate_usr!
  def new
    account_id = params[:account]
    @amount = params[:amount]
    if account_id.nil? or !Account.exists?(account_id)
      redirect_to accounts_path, alert: 'Internal server error', status: :internal_server_error
      return
    end
    @account = Account.find(account_id)

    unless @account.donate_qr_code.attached? or @account.donate_qr_code.nil?
      puts 'generating qr code'
      redirect_to accounts_path
      @account.generate_donate_qr_code
    end

    @donate_link = new_transaction_url(percipient: account_id, note: 'Donate to ' + current_usr.full_name)
  end
end
