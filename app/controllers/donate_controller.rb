class DonateController < ApplicationController
  def new
    account_id = params[:account]
    @amount = params[:amount]
    if account_id == nil
      redirect_to accounts_path, alert: "Internal server error", status: :internal_server_error
      return
    end
    @donate_link = new_transaction_url(percipient: account_id, note: "Donate to " + Current.user.full_name)
  end
end
