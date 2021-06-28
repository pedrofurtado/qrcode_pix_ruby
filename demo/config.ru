# frozen_string_literal: true

require 'qrcode_pix_ruby'

def generate_html_with(env)
  post_data = Rack::Request.new(env)

  StringIO.new <<-HTML
  <!DOCTYPE html>
  <html>
    <head>
      <title>QRCode Pix Ruby - Demo App</title>
    </head>
    <body>
      <h1>QRCode Pix Ruby - Demo App 4 ... #{post_data.params.inspect}</h1>
      <form action='https://qrcode-pix-ruby.herokuapp.com' method='post'>
        <input type='text' name='abc'>
        <input type='submit' value='Gerar QRCode'>
      </form>
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
