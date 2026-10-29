
import qrcode

data = "{id:6}"

qr = qrcode.QRCode(
    version=1,
    box_size=10,
    border=4
)

qr.add_data(data)
qr.make(fit=True)

image = qr.make_image(
    fill_color="black",
    back_color="white"
)

image.save("./lib/code_generator/barcode_images/visitor_qr.png")

print("QR code generated successfully!")
print("QR data:", data)
