class AccountsController < ApplicationController
  before_action :authenticate_usr!
  before_action :set_account, only: %i[show edit update destroy]

  # GET /accounts or /accounts.json
  def index

  end

# GET /accounts/1 or /accounts/1.json
  def show
    session[:a] = @account.id
    file_name = @account.name + "-" + Time.zone.now.to_datetime.strftime('%d.%m.%Y')
    respond_to do |format|
      format.html
      format.csv do
        send_data @account.to_csv, filename: @account.name, content_type: 'text/csv' # TODO filename not working
      end
      format.xlsx do
        render xlsx: 'show', filename: file_name
      end
      format.pdf do
        render pdf: @account.name, template: "accounts/pdf", formats: [:html], orientation: 'Landscape', layout: 'pdf'
      end
      format.json do
        render json: @account
      end
    end
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit; end

  # POST /accounts or /accounts.json
  def create
    @account = Account.new(account_params)
    @account.usr_id = current_usr.id

    if @account.save
      redirect_to accounts_path, notice: 'Account was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accounts/1 or /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(name: params[:account][:name])
        format.html { redirect_to account_url(@account), notice: 'Account was successfully renamed.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1 or /accounts/1.json
  def destroy
    unless @account.value == 0
      redirect_to @account, alert: "You can't destroy this account, it has money on it."
      return
    end
    @account.destroy

    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def redirect
    redirect_to accounts_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def account_params
    params.require(:account).permit(:name, :currency, :donate_qr_code)
  end
end
