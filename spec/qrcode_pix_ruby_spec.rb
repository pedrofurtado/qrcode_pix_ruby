# frozen_string_literal: true

RSpec.describe QrcodePixRuby do
  it 'QRCode - Base64'

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
end
