class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]
  before_action :authenticate_usr!
  before_action :set_current_account  

  # GET /transactions/new
  def new
    @transaction = Transaction.new(
      recipient_id: params[:recipient],
      note: params[:note],
      amount: params[:amount]
    )
    if params[:sender] == nil
      @transaction.sender = current_usr.accounts.first
    else
      @transaction.sender_id = params[:sender]
    end
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.sender = Current.account

    respond_to do |format|
      if @transaction.valid?
        unless current_usr.accounts.include? @transaction.sender
          redirect_to accounts_path, alert: "You can't send money from account which is not yours!!!"
          return
        end

        unless @transaction.commit
          redirect_to new_transaction_path, alert: "You can't send more money than you have on your account!!!"
          return
        end

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
