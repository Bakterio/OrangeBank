class QrTransactionController < ApplicationController
  def generator # get

  end

  def generate # post
    @link = new_transaction_url(recipient_id: params[:recipient], amount: params[:amount], note: params[:note], variable_symbol: params[:variable_symbol])
    puts @link
  end
end
