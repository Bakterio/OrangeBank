module QrTransactionHelper
  def generate_svg_qrcode(link)
    RQRCode::QRCode.new(link.to_s).as_svg(
      module_size: 5,
      offset: 20
    ).html_safe
  end
end
