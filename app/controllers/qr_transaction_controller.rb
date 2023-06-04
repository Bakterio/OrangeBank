class QrTransactionController < ApplicationController
  def generator # get
    @transaction = Transaction.new(recipient_id: params[:recipient]) unless params[:recipient].nil?
    @record = current_usr.transactionqrcode
  end

  def generate # post
    link = new_transaction_url(recipient_id: params[:recipient], amount: params[:amount], note: params[:note], variable_symbol: params[:variable_symbol])
    record = Transactionqrcode.create(link: link, usr_id: current_usr.id)
    qrcode = RQRCode::QRCode.new(link)

    png = qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: "black",
      file: nil,
      fill: "white",
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 250
    )

    record.qr_code.attach(
      io: StringIO.new(png.to_s),
      filename: "qrcode.png",
      content_type: "image/png"
    )

    current_usr.transactionqrcode.destroy! unless current_usr.transactionqrcode.nil?
    record.save!
    current_usr.transactionqrcode = record
    redirect_to qr_generator_path
  end
end
