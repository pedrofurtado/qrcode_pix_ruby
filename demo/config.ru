# frozen_string_literal: true

run lambda do |env|
  [
    200,
    {
      'Content-Type' => 'text/plain'
    },
    StringIO.new("Hello World!")
  ]
end
