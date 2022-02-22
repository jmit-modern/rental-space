require "rqrcode"

class QrcodeService
  def self.generate_qr_aws_image(link)
    qrcode = RQRCode::QRCode.new(link)

    # NOTE: showing with default options specified explicitly
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
      size: 200,
    )

    obj = S3_BUCKET.object("uploads/#{SecureRandom.uuid}/qr_code.png")
    obj.put(body: png.to_s, acl: "public-read")

    return obj.public_url
  end
end
