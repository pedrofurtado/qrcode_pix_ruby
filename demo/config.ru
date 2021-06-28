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
      <title>QRCode Pix Ruby - Demo App</title>
    </head>
    <body>
      <h1>QRCode Pix Ruby - Demo App ... #{qrcode_data.params.inspect}</h1>
      <br>
      <form action='https://qrcode-pix-ruby.herokuapp.com' method='post'>
        <input type='text' name='pix_key' placeholder='Chave do PIX'>
        <br>
        <input type='text' name='description'    placeholder='Descrição do pagamento'>
        <br>
        <input type='text' name='merchant_name'  placeholder='Nome do titular'>
        <br>
        <input type='text' name='merchant_city'  placeholder='Cidade do titular'>
        <br>
        <input type='text' name='transaction_id' placeholder='ID da transação'>
        <br>
        <input type='text' name='amount'         placeholder='Valor'>
        <br>
        <input type='text' name='currency'       placeholder='Moeda'>
        <br>
        <input type='text' name='country_code'   placeholder='País'>
        <br>
        <input type='text' name='postal_code'    placeholder='Código Postal'>
        <br>
        <input type='text' name='repeatable'     placeholder='Repetível?'>
        <br>
        <input type='submit' value='Gerar QRCode'>
      </form>
      <br>
      #{payload}
      <br>
      #{data_uri}
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
