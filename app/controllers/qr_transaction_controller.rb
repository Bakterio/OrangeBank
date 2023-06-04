class QrTransactionController < ApplicationController
  def generator # get
    @record = Transactionqrcode.find(session[:qr_code_id])
  end

  def generate # post
    link = new_transaction_url(recipient_id: params[:recipient], amount: params[:amount], note: params[:note], variable_symbol: params[:variable_symbol])
    url = Rails.application.routes.url_helpers.root_url + link
    record = Transactionqrcode.create!(link: link)
    qrcode = RQRCode::QRCode.new(url)

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

    session[:qr_code_id] = record.id
    redirect_to qr_generator_path
  end
end
