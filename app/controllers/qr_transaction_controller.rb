class QrTransactionController < ApplicationController
  def generator # get
    @transaction = Transaction.new(recipient_id: params[:recipient]) unless params[:recipient].nil?
    unless session[:qrcode_link].nil?
      @link = session[:qrcode_link]
    else
      @link = root_url
    end
  end

  def generate # post
    session[:qrcode_link] = new_transaction_url(recipient_id: params[:recipient], amount: params[:amount], note: params[:note], variable_symbol: params[:variable_symbol])
    redirect_to qr_generator_path
  end
end
