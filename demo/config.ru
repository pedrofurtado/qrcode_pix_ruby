# frozen_string_literal: true

require 'qrcode_pix_ruby'

def generate_html_with(env)
  qrcode_data = Rack::Request.new(env).params
  payload = ''
  data_uri = ''
  pix = QrcodePixRuby::Payload.new

  unless qrcode_data.empty?
    pix.pix_key        = qrcode_data['pix_key']        unless qrcode_data['pix_key'].nil?
    pix.description    = qrcode_data['description']    unless qrcode_data['description'].nil?
    pix.merchant_name  = qrcode_data['merchant_name']  unless qrcode_data['merchant_name'].nil?
    pix.merchant_city  = qrcode_data['merchant_city']  unless qrcode_data['merchant_city'].nil?
    pix.transaction_id = qrcode_data['transaction_id'] unless qrcode_data['transaction_id'].nil?
    pix.amount         = qrcode_data['amount']         unless qrcode_data['amount'].nil?
    pix.currency       = qrcode_data['currency']       unless qrcode_data['currency'].nil?
    pix.country_code   = qrcode_data['country_code']   unless qrcode_data['country_code'].nil?
    pix.postal_code    = qrcode_data['postal_code']    unless qrcode_data['postal_code'].nil?
    pix.repeatable     = qrcode_data['repeatable']     unless qrcode_data['repeatable'].nil?

    payload = "<p>#{pix.payload}</p>"
    data_uri = "<img src='#{pix.base64}'>"
  end

  StringIO.new <<-HTML
    <!DOCTYPE html>
    <html>
      <head>
        <meta charset='utf-8'>
        <meta name='viewport' content='width=device-width, initial-scale=1'>
        <link href='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css' rel='stylesheet'>
        <title>QRCode Pix Ruby - Demo App</title>
      </head>
      <body>
        <div class='container'>
          <div class='row'>
            <div class='col-sm-6'>
              <strong>Data</strong>
              <form action='https://qrcode-pix-ruby.herokuapp.com' method='post'>
                <div class='form-floating mb-3'>
                  <input type='text' class='form-control' id='float-label-of-pix_key' name='pix_key' placeholder='Chave do PIX'>
                  <label for='float-label-of-pix_key'></label>
                </div>
                <div class='form-floating mb-3'>
                  <input type='text' class='form-control' id='float-label-of-description' name='description' placeholder='Descrição do pagamento'>
                  <label for='float-label-of-description'></label>
                </div>
                <div class='form-floating mb-3'>
                  <input type='text' class='form-control' id='float-label-of-merchant_name' name='merchant_name' placeholder='Nome do titular'>
                  <label for='float-label-of-merchant_name'></label>
                </div>
                <div class='form-floating mb-3'>
                  <input type='text' class='form-control' id='float-label-of-merchant_city' name='merchant_city' placeholder='Cidade do titular'>
                  <label for='float-label-of-merchant_city'></label>
                </div>
                <div class='form-floating mb-3'>
                  <input type='text' class='form-control' id='float-label-of-transaction_id' name='transaction_id' placeholder='ID da transação'>
                  <label for='float-label-of-transaction_id'></label>
                </div>
                <div class='form-floating mb-3'>
                  <input type='text' class='form-control' id='float-label-of-amount' name='amount' placeholder='Valor'>
                  <label for='float-label-of-amount'></label>
                </div>
                <div class='form-floating mb-3'>
                  <input type='text' class='form-control' id='float-label-of-currency' name='currency' placeholder='Moeda'>
                  <label for='float-label-of-currency'></label>
                </div>
                <div class='form-floating mb-3'>
                  <input type='text' class='form-control' id='float-label-of-country_code' name='country_code' placeholder='País'>
                  <label for='float-label-of-country_code'></label>
                </div>
                <div class='form-floating mb-3'>
                  <input type='text' class='form-control' id='float-label-of-postal_code' name='postal_code' placeholder='Código Postal'>
                  <label for='float-label-of-postal_code'></label>
                </div>
                <div class='form-floating mb-3'>
                  <input type='text' class='form-control' id='float-label-of-repeatable' name='repeatable' placeholder='Repetível?'>
                  <label for='float-label-of-repeatable'></label>
                </div>
                <input type='submit' value='Gerar QRCode'>
              </form>
            </div>
            <div class='col-sm-6'>
              <strong>Preview</strong>
              #{payload}
              <br>
              #{data_uri}
            </div>
          </div>
        </div>
      </body>
    </html>
  HTML
end

run lambda { |env|
  [
    200,
    {
      'Content-Type' => 'text/html'
    },
    generate_html_with(env)
  ]
}
