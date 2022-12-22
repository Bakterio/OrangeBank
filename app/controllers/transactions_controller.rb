class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]
  before_action :require_user_logged_in
  before_action :set_current_account  

  # GET /transactions/new
  def new
    if Current.account.nil?
      redirect_to accounts_path, alert: "Server error, please select your account once again"
      return
    end

    #@account = Account.find(params[:a])
    @transaction = Transaction.new
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.sender = Current.account

    respond_to do |format|
      if @transaction.valid?
        unless Current.user.accounts.include? @transaction.sender
          redirect_to accounts_path, alert: "You can't send money from account which is not yours!!!"
          return
        end

        unless @transaction.commit
          puts "err"
          redirect_to new_transaction_path, alert: "You can't send more money than you have on your account!!!"
          return
        end
        @transaction.save

        format.html { redirect_to account_path(@transaction.sender), notice: "Transaction was successfully commited." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:note, :my_note, :variable_symbol, :amount, :recipient_id)
    end
end
