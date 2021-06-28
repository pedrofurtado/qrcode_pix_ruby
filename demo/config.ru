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

    payload = <<-HTML
      <div class='input-group mb-3'>
        <input class='form-control' id='payload' value='#{pix.payload}'>
        <button class='btn btn-outline-success btn-clipboard' data-clipboard-target='#payload' data-bs-toggle='tooltip' data-bs-placement='top' title='Copied!' data-trigger='click'>Copy</button>
      </div>
    HTML

    data_uri = "<img src='#{pix.base64}'>"
  end

  StringIO.new <<-HTML
    <!DOCTYPE html>
    <html>
      <head>
        <meta charset='utf-8'>
        <meta name='viewport' content='width=device-width, initial-scale=1'>
        <link href='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css' rel='stylesheet'>
        <script src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js'></script>
        <script src='https://cdn.jsdelivr.net/npm/clipboard@2.0.8/dist/clipboard.min.js'></script>
        <title>QRCode Pix Ruby - Demo App</title>
      </head>
      <body>
        <div class='container' style='margin-top: 50px;'>
          <div class='row'>
            <div class='col-md-12'>
              <h1 class='text-center'>QRCode Pix Ruby - Demo App</h1>
              <br>
              <img style='display: block; margin: 0 auto;' src="https://github.com/pedrofurtado/qrcode_pix_ruby/blob/master/pix_logo.png?raw=true" height="100px" />
              <br>
              <p class='text-center'>For more details check the official repo: <a href="https://github.com/pedrofurtado/qrcode_pix_ruby">https://github.com/pedrofurtado/qrcode_pix_ruby</a></p>
              <br>
              <br>
            </div>
          </div>
          <div class='row' style='padding-bottom: 50px;'>
            <div class='col-sm-6'>
              <strong>QRCode informations</strong>
              <br>
              <br>
              <form action='https://qrcode-pix-ruby.herokuapp.com' method='post'>
                <div class='mb-3'>
                  <label for='pix_key'>Chave do PIX</label>
                  <input type='text' class='form-control' id='pix_key' value='#{qrcode_data["pix_key"]}' name='pix_key'>
                </div>
                <div class='mb-3'>
                  <label for='description'>Descrição do pagamento</label>
                  <input type='text' class='form-control' id='description' value='#{qrcode_data["description"]}' name='description'>
                </div>
                <div class='mb-3'>
                  <label for='merchant_name'>Nome do titular</label>
                  <input type='text' class='form-control' id='merchant_name' value='#{qrcode_data["merchant_name"]}' name='merchant_name'>
                </div>
                <div class='mb-3'>
                  <label for='merchant_city'>Cidade do titular</label>
                  <input type='text' class='form-control' id='merchant_city' value='#{qrcode_data["merchant_city"]}' name='merchant_city'>
                </div>
                <div class='mb-3'>
                  <label for='transaction_id'>ID da transação</label>
                  <input type='text' class='form-control' id='transaction_id' value='#{qrcode_data["transaction_id"]}' name='transaction_id'>
                </div>
                <div class='mb-3'>
                  <label for='amount'>Valor</label>
                  <input type='text' class='form-control' id='amount' value='#{qrcode_data["amount"]}' name='amount'>
                </div>
                <div class='mb-3'>
                  <label for='currency'>Moeda</label>
                  <input type='text' class='form-control' id='currency' value='#{qrcode_data["currency"]}' name='currency'>
                </div>
                <div class='mb-3'>
                  <label for='country_code'>País</label>
                  <input type='text' class='form-control' id='country_code' value='#{qrcode_data["country_code"]}' name='country_code'>
                </div>
                <div class='mb-3'>
                  <label for='postal_code'>Código Postal</label>
                  <input type='text' class='form-control' id='postal_code' value='#{qrcode_data["postal_code"]}' name='postal_code'>
                </div>
                <div class='mb-3'>
                  <label for='repeatable'>Repetível?</label>
                  <input type='text' class='form-control' id='repeatable' value='#{qrcode_data["repeatable"]}' name='repeatable'>
                </div>
                <div class='d-grid gap-2'>
                  <button type='submit' class='btn btn-lg btn-primary'>Generate QRCode</button>
                </div>
              </form>
            </div>
            <div class='col-sm-6'>
              <strong>Preview</strong>
              <br>
              <br>
              #{payload}
              <br>
              <br>
              #{data_uri}
            </div>
          </div>
        </div>
        <script>
          new ClipboardJS('.btn-clipboard');

          Array.from(document.querySelectorAll('[data-bs-toggle="tooltip"]')).forEach(function (tooltipTriggerEl) {
            new bootstrap.Tooltip(tooltipTriggerEl);
          });
        </script>
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
