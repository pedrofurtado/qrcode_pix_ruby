# frozen_string_literal: true

RSpec.describe PixRuby do
  it "has a version number" do
    expect(PixRuby::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(true).to eq(true)
  end

  it "generate sample static payload" do
    pix_qrcode_payload = PixRuby::QrCode::Static.new
    pix_qrcode_payload.pix_key = '12345678900'
    pix_qrcode_payload.description = 'Pagamento do pedido 123456' # 'Descrição do pagamento, que irá aparecer na tela do app do banco'
    pix_qrcode_payload.merchant_name = 'William Costa' # nome dotitular da conta
    pix_qrcode_payload.merchant_city = 'SAO PAULO' # 'Cidade do titular da conta'
    pix_qrcode_payload.txid = 'WDEV1234' # 'ID da transação'
    pix_qrcode_payload.amount = '100.00' # precisa ter 2 casas apos o ponto, tem q separar por ponto E NAO pode ter separador de milhar.
    expect(pix_qrcode_payload.payload).to eq('00020126630014br.gov.bcb.pix0111123456789000226Pagamento do pedido 1234565204000053039865406100.005802BR5913William Costa6009SAO PAULO62120508WDEV12346304E9BF')
  end
end
