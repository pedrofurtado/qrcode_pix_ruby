# frozen_string_literal: true

RSpec.describe QrcodePixRuby do
  it 'has a valid version number' do
    expect(QrcodePixRuby::VERSION).not_to be nil
    expect(QrcodePixRuby::VERSION).to match /^[0-9]+\.[0-9]+\.[0-9]+$/
  end

  it 'generates default payload and base64, when nothing is defined' do
    pix = QrcodePixRuby::Payload.new
    expect(pix.payload).to eq '00020126260014br.gov.bcb.pix0100020052040000530398654005802BR5900600062040500630462E0'
    expect(pix.base64).to eq ''
  end

  it 'generates valids payloads and base64' do
    pix = QrcodePixRuby::Payload.new

    pix.pix_key        = '12345678900'
    pix.description    = 'Pagamento do pedido 123456'
    pix.merchant_name  = 'William Costa'
    pix.merchant_city  = 'SAO PAULO'
    pix.transaction_id = 'WDEV1234'
    pix.amount         = '100.00'

    expect(pix.payload).to eq '00020126630014br.gov.bcb.pix0111123456789000226Pagamento do pedido 1234565204000053039865406100.005802BR5913William Costa6009SAO PAULO62120508WDEV12346304E9BF'
    expect(pix.base64).to eq ''
  end
end
