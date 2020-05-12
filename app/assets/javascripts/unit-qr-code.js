//= require qr-code

$(document).ready(function () {
  var QRCodeElement = $("#qrcode");
  var qrcode = new QRCode(QRCodeElement, {
    text: QRCodeElement.attr("data-qrcode-url"),
    colorDark: "#000000",
    colorLight: "#ffffff",
    correctLevel: QRCode.CorrectLevel.H,
  });
});
