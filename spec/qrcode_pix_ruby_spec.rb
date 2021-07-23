# frozen_string_literal: true

RSpec.describe QrcodePixRuby do
  let(:attributes) { {} }

  let(:payload) { subject.payload }
  let(:base64) { subject.base64 }

  describe 'Attributes validation' do
    subject { QrcodePixRuby::Payload.new(**attributes) }

    let(:error) { QrcodePixRuby::PayloadArgumentError }

    context 'only one' do
      let(:attributes) { { abc: 'abc' } }

      it 'raise error and show the unknown attribute' do
        expect { subject }.to raise_error(error, 'Unknown attributes: abc')
      end
    end

    context 'more then one' do
      let(:attributes) { { abc: 'abc', dfg: 'dfg' } }

      it 'raise error and show the unknown attributes' do
        expect { subject }.to raise_error(error, 'Unknown attributes: abc, dfg')
      end
    end
  end

  describe 'Static QR Code' do
    subject do
      QrcodePixRuby::Payload.new(
        pix_key: 'pedro.felipe.azevedo.furtado@gmail.com',
        merchant_name: 'PEDRO FURTADO',
        merchant_city: 'SAO PAULO',
        **attributes
      )
    end

    describe 'QRCode - Basic' do
      it 'has a valid payload' do
        expect(payload).to eq '00020101021226600014BR.GOV.BCB.PIX0138pedro.felipe.azevedo.furtado@gmail.com5204000053039865802BR5913PEDRO FURTADO6009SAO PAULO62070503***63046B4C'
      end

      it 'has a valid base64' do
        expect(base64).to eq file_fixture('basic.base64').read
      end
    end

    describe 'QRCode - Currency' do
      context 'when currency is 986' do
        let(:attributes) { { currency: '986' } }

        it 'has a valid payload' do
          expect(payload).to eq '00020101021226600014BR.GOV.BCB.PIX0138pedro.felipe.azevedo.furtado@gmail.com5204000053039865802BR5913PEDRO FURTADO6009SAO PAULO62070503***63046B4C'
        end

        it 'has a valid base64' do
          expect(base64).to eq file_fixture('currency_986.base64').read
        end
      end

      context 'when currency is 123' do
        let(:attributes) { { currency: '123' } }

        it 'has a valid payload' do
          expect(payload).to eq '00020101021226600014BR.GOV.BCB.PIX0138pedro.felipe.azevedo.furtado@gmail.com5204000053031235802BR5913PEDRO FURTADO6009SAO PAULO62070503***63047E2C'
        end

        it 'has a valid base64' do
          expect(base64).to eq file_fixture('currency_123.base64').read
        end
      end
    end

    describe 'QRCode - Amount' do
      context 'when amount is 100.99' do
        let(:attributes) { { amount: '100.99' } }

        it 'has a valid payload' do
          expect(payload).to eq '00020101021226600014BR.GOV.BCB.PIX0138pedro.felipe.azevedo.furtado@gmail.com5204000053039865406100.995802BR5913PEDRO FURTADO6009SAO PAULO62070503***63045059'
        end

        it 'has a valid base64' do
          expect(base64).to eq file_fixture('amount_100_99.base64').read
        end
      end

      context 'when amount is 0.01' do
        let(:attributes) { { amount: '0.01' } }

        it 'has a valid payload' do
          expect(payload).to eq '00020101021226600014BR.GOV.BCB.PIX0138pedro.felipe.azevedo.furtado@gmail.com52040000530398654040.015802BR5913PEDRO FURTADO6009SAO PAULO62070503***6304A136'
        end

        it 'has a valid base64' do
          expect(base64).to eq file_fixture('amount_0_01.base64').read
        end
      end
    end

    describe 'QRCode - Country code' do
      context 'when country_code is BR' do
        let(:attributes) { { country_code: 'BR' } }

        it 'has a valid payload' do
          expect(payload).to eq '00020101021226600014BR.GOV.BCB.PIX0138pedro.felipe.azevedo.furtado@gmail.com5204000053039865802BR5913PEDRO FURTADO6009SAO PAULO62070503***63046B4C'
        end

        it 'has a valid base64' do
          expect(base64).to eq file_fixture('country_code_BR.base64').read
        end
      end

      context 'when country_code is US' do
        let(:attributes) { { country_code: 'US' } }

        it 'has a valid payload' do
          expect(payload).to eq '00020101021226600014BR.GOV.BCB.PIX0138pedro.felipe.azevedo.furtado@gmail.com5204000053039865802US5913PEDRO FURTADO6009SAO PAULO62070503***63049DF5'
        end

        it 'has a valid base64' do
          expect(base64).to eq file_fixture('country_code_US.base64').read
        end
      end
    end

    describe 'QRCode - Postal code' do
      context 'when postal_code is 01134000' do
        let(:attributes) { { postal_code: '01134000' } }

        it 'has a valid payload' do
          expect(payload).to eq '00020101021226600014BR.GOV.BCB.PIX0138pedro.felipe.azevedo.furtado@gmail.com5204000053039865802BR5913PEDRO FURTADO6009SAO PAULO61080113400062070503***630497E2'
        end

        it 'has a valid base64' do
          expect(base64).to eq file_fixture('postal_code_01134000.base64').read
        end
      end

      context 'when postal_code is 01131010' do
        let(:attributes) { { postal_code: '01131010' } }

        it 'has a valid payload' do
          expect(payload).to eq '00020101021226600014BR.GOV.BCB.PIX0138pedro.felipe.azevedo.furtado@gmail.com5204000053039865802BR5913PEDRO FURTADO6009SAO PAULO61080113101062070503***63041100'
        end

        it 'has a valid base64' do
          expect(base64).to eq file_fixture('postal_code_01131010.base64').read
        end
      end
    end

    describe 'QRCode - Transaction ID' do
      context 'when transaction_id is PIX123' do
        let(:attributes) { { transaction_id: 'PIX123' } }

        it 'has a valid payload' do
          expect(payload).to eq '00020101021226600014BR.GOV.BCB.PIX0138pedro.felipe.azevedo.furtado@gmail.com5204000053039865802BR5913PEDRO FURTADO6009SAO PAULO62100506PIX12363046BE4'
        end

        it 'has a valid base64' do
          expect(base64).to eq file_fixture('transaction_id_PIX123.base64').read
        end
      end

      context 'when transaction_id is PIXPEDRO' do
        let(:attributes) { { transaction_id: 'PIXPEDRO' } }

        it 'has a valid payload' do
          expect(payload).to eq '00020101021226600014BR.GOV.BCB.PIX0138pedro.felipe.azevedo.furtado@gmail.com5204000053039865802BR5913PEDRO FURTADO6009SAO PAULO62120508PIXPEDRO630428E7'
        end

        it 'has a valid base64' do
          expect(base64).to eq file_fixture('transaction_id_PIXPEDRO.base64').read
        end
      end
    end

    describe 'QRCode - Description' do
      context 'when description is Bora pagar?' do
        let(:attributes) { { description: 'Bora pagar?' } }

        it 'has a valid payload' do
          expect(payload).to eq '00020101021226750014BR.GOV.BCB.PIX0138pedro.felipe.azevedo.furtado@gmail.com0211Bora pagar?5204000053039865802BR5913PEDRO FURTADO6009SAO PAULO62070503***6304BC58'
        end

        it 'has a valid base64' do
          expect(base64).to eq file_fixture('description_Bora_pagar.base64').read
        end
      end

      context 'when description is PIX 123' do
        let(:attributes) { { description: 'PIX 123' } }

        it 'has a valid payload' do
          expect(payload).to eq '00020101021226710014BR.GOV.BCB.PIX0138pedro.felipe.azevedo.furtado@gmail.com0207PIX 1235204000053039865802BR5913PEDRO FURTADO6009SAO PAULO62070503***6304D936'
        end

        it 'has a valid base64' do
          expect(base64).to eq file_fixture('description_PIX_123.base64').read
        end
      end
    end

    describe 'QRCode - Repeatable' do
      context 'when repeatable is false' do
        let(:attributes) { { repeatable: false } }

        it 'has a valid payload' do
          expect(payload).to eq '00020101021226600014BR.GOV.BCB.PIX0138pedro.felipe.azevedo.furtado@gmail.com5204000053039865802BR5913PEDRO FURTADO6009SAO PAULO62070503***63046B4C'
        end

        it 'has a valid base64' do
          expect(base64).to eq file_fixture('repeatable_false.base64').read
        end
      end

      context 'when repeatable is true' do
        let(:attributes) { { repeatable: true } }

        it 'has a valid payload' do
          expect(payload).to eq '00020101021126600014BR.GOV.BCB.PIX0138pedro.felipe.azevedo.furtado@gmail.com5204000053039865802BR5913PEDRO FURTADO6009SAO PAULO62070503***630468A4'
        end

        it 'has a valid base64' do
          expect(base64).to eq file_fixture('repeatable_true.base64').read
        end
      end
    end
  end

  describe 'Dynamic QR Code' do
    subject do
      QrcodePixRuby::Payload.new(
        url: 'https://qrcodes-pix-h.gerencianet.com.br/v2/3074067216ec4341949e07872a163799',
        merchant_name: 'William Costa',
        merchant_city: 'SAO PAULO',
        amount: '10.00',
        transaction_id: 'WDEV1234123412340000000005',
        repeatable: false,
        **attributes
      )
    end

    describe 'QRCode - URL' do
      it 'has a valid payload' do
        expect(payload).to eq '00020101021226900014BR.GOV.BCB.PIX2568qrcodes-pix-h.gerencianet.com.br/v2/3074067216ec4341949e07872a163799520400005303986540510.005802BR5913William Costa6009SAO PAULO62300526WDEV12341234123400000000056304D37C'
      end

      it 'has a valid base64' do
        expect(base64).to eq file_fixture('url.base64').read
      end
    end
  end
end
