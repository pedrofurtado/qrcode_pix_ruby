# frozen_string_literal: true

RSpec.describe QrcodePixRuby do
  before :each do
    @pix                = QrcodePixRuby::Payload.new
    @pix.pix_key        = 'pedro.felipe.azevedo.furtado@gmail.com'
    @pix.merchant_name  = 'PEDRO FURTADO'
    @pix.merchant_city  = 'SAO PAULO'
  end

  it 'QRCode - Payload - Basic' do
    expect(@pix.payload).to eq ''
    expect(pix.base64).to eq ''
  end

  it 'QRCode - Payload - Currency' do
    @pix.currency = '986'
    expect(@pix.payload).to eq ''
    expect(pix.base64).to eq ''

    @pix.currency = '123'
    expect(@pix.payload).to eq ''
    expect(pix.base64).to eq ''
  end

  it 'QRCode - Payload - Value' do
    @pix.amount = '100.99'
    expect(@pix.payload).to eq ''
    expect(pix.base64).to eq ''

    @pix.amount = '0.01'
    expect(@pix.payload).to eq ''
    expect(pix.base64).to eq ''
  end

  it 'QRCode - Payload - Country code' do
    @pix.country_code = 'BR'
    expect(@pix.payload).to eq ''
    expect(pix.base64).to eq ''

    @pix.country_code = 'US'
    expect(@pix.payload).to eq ''
    expect(pix.base64).to eq ''
  end

  it 'QRCode - Payload - Postal code' do
    @pix.postal_code = '01134000'
    expect(@pix.payload).to eq ''
    expect(pix.base64).to eq ''

    @pix.postal_code = '01131010'
    expect(@pix.payload).to eq ''
    expect(pix.base64).to eq ''
  end

  it 'QRCode - Payload - Transaction ID' do
    @pix.transaction_id = 'PIX123'
    expect(@pix.payload).to eq ''
    expect(pix.base64).to eq ''

    @pix.transaction_id = 'PIXPEDRO'
    expect(@pix.payload).to eq ''
    expect(pix.base64).to eq ''
  end

  it 'QRCode - Payload - Description' do
    @pix.description = 'Bora pagar?'
    expect(@pix.payload).to eq ''
    expect(pix.base64).to eq ''

    @pix.description = 'PIX 123'
    expect(@pix.payload).to eq ''
    expect(pix.base64).to eq ''
  end

  it 'QRCode - Payload - Repeatable' do
    @pix.repeatable = false
    expect(@pix.payload).to eq ''
    expect(pix.base64).to eq ''

    @pix.repeatable = true
    expect(@pix.payload).to eq ''
    expect(pix.base64).to eq ''
  end

  it 'QRCode - Base64' do
    expect(pix.base64).to eq ''
  end
end
