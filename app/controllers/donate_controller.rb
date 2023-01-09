class DonateController < ApplicationController
  def new
    account_id = params[:account]
    @amount = params[:amount]
    if account_id == nil
      redirect_to accounts_path, alert: "Internal server error", status: :internal_server_error
      return
    end
    @donate_link = send_donate_url(percipient: account_id)
  end

  def send_donate
    redirect_to new_transaction_path(percipient: params[:percipient])
  end
end
