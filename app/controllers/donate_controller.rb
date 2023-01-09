class DonateController < ApplicationController
  def new
    account_id = params[:account]
    @amount = params[:amount]
    if account_id == nil
      redirect_to accounts_path, alert: "Internal server error", status: :internal_server_error
      return
    end
    @account = Account.find(account_id)
  end

  def create
    amount = params[:amount]
    account = params[:account]
    unless amount_formated?(amount)
      redirect_back fallback_location: accounts_path, alert: "Wrong amount formatting."
      return
    end
    @donate_link = "test"
    redirect_back fallback_location: accounts_path
  end

  private
  def amount_formated?(amount)
    return true
  end
end
