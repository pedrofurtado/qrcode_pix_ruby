# frozen_string_literal: true

require 'qrcode_pix_ruby'

run lambda { |env|
  puts env.inspect

  [
    200,
    {
      'Content-Type' => 'text/plain'
    },
    StringIO.new('Hello World 2!')
  ]
}
