# frozen_string_literal: true

RSpec.describe QrcodePixRuby do
  it 'QRCode - Payload - 01 - Basic' do
    pix = QrcodePixRuby::Payload.new

    pix.pix_key        = 'test@mail.com.br'
    pix.merchant_name  = 'Fulano de Tal'
    pix.merchant_city  = 'SAO PAULO'

    expect(pix.payload).to eq '00020101021126380014BR.GOV.BCB.PIX0116test@mail.com.br5204000053039865802BR5913Fulano de Tal6009SAO PAULO62070503***6304BCD7'
  end

  it 'QRCode - Payload - 02 - Currency' do
    pix = QrcodePixRuby::Payload.new

    pix.pix_key        = 'test@mail.com.br'
    pix.merchant_name  = 'Fulano de Tal'
    pix.merchant_city  = 'SAO PAULO'
    pix.currency       = '986'

    expect(pix.payload).to eq '00020101021126380014BR.GOV.BCB.PIX0116test@mail.com.br5204000053039865802BR5913Fulano de Tal6009SAO PAULO62070503***6304BCD7'
  end

  it 'QRCode - Payload - 03 - Value' do
    pix = QrcodePixRuby::Payload.new

    pix.pix_key        = 'test@mail.com.br'
    pix.merchant_name  = 'Fulano de Tal'
    pix.merchant_city  = 'SAO PAULO'
    pix.amount         = '100.99'

    expect(pix.payload).to eq '00020101021126380014BR.GOV.BCB.PIX0116test@mail.com.br5204000053039865406100.995802BR5913Fulano de Tal6009SAO PAULO62070503***6304B432'
  end

  it 'QRCode - Payload - 04 - Country code' do
    pix = QrcodePixRuby::Payload.new

    pix.pix_key        = 'test@mail.com.br'
    pix.merchant_name  = 'Fulano de Tal'
    pix.merchant_city  = 'SAO PAULO'
    pix.country_code   = 'BR'

    expect(pix.payload).to eq '00020101021126380014BR.GOV.BCB.PIX0116test@mail.com.br5204000053039865802BR5913Fulano de Tal6009SAO PAULO62070503***6304BCD7'
  end

  it 'QRCode - Payload - 05 - Postal code' do
    pix = QrcodePixRuby::Payload.new

    pix.pix_key        = 'test@mail.com.br'
    pix.merchant_name  = 'Fulano de Tal'
    pix.merchant_city  = 'SAO PAULO'
    pix.postal_code    = '85000100'

    expect(pix.payload).to eq '00020101021126380014BR.GOV.BCB.PIX0116test@mail.com.br5204000053039865802BR5913Fulano de Tal6009SAO PAULO61088500010062070503***6304558C'
  end

  it 'QRCode - Payload - 06 - Transaction ID' do
    pix = QrcodePixRuby::Payload.new

    pix.pix_key        = 'test@mail.com.br'
    pix.merchant_name  = 'Fulano de Tal'
    pix.merchant_city  = 'SAO PAULO'
    pix.transaction_id = 'my_transaction_id'

    expect(pix.payload).to eq '00020101021126380014BR.GOV.BCB.PIX0116test@mail.com.br5204000053039865802BR5913Fulano de Tal6009SAO PAULO62210517my_transaction_id63046247'
  end

  it 'QRCode - Payload - 07 - Description' do
    pix = QrcodePixRuby::Payload.new

    pix.pix_key        = 'test@mail.com.br'
    pix.merchant_name  = 'Fulano de Tal'
    pix.merchant_city  = 'SAO PAULO'
    pix.description    = 'is my message :)'

    expect(pix.payload).to eq '00020101021126580014BR.GOV.BCB.PIX0116test@mail.com.br0216is my message :)5204000053039865802BR5913Fulano de Tal6009SAO PAULO62070503***6304A39D'
  end

  it 'QRCode - Payload - 08 - Repeatable' do
    pix = QrcodePixRuby::Payload.new

    pix.pix_key        = 'test@mail.com.br'
    pix.merchant_name  = 'Fulano de Tal'
    pix.merchant_city  = 'SAO PAULO'
    pix.repeatable     = false

    expect(pix.payload).to eq '00020101021126380014BR.GOV.BCB.PIX0116test@mail.com.br5204000053039865802BR5913Fulano de Tal6009SAO PAULO62070503***6304BCD7'
  end

  it 'QRCode - Base64' do
    pix = QrcodePixRuby::Payload.new

    pix.pix_key        = 'test@mail.com.br'
    pix.merchant_name  = 'Fulano de Tal'
    pix.merchant_city  = 'SAO PAULO'

    expect(pix.base64).to eq 'data:image/png;base64,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'
  end
end
