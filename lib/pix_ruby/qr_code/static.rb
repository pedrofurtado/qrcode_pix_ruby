# frozen_string_literal: true

module PixRuby
  module QrCode
    class Static
      ID_PAYLOAD_FORMAT_INDICATOR = '00'.freeze
      ID_MERCHANT_ACCOUNT_INFORMATION = '26'.freeze
      ID_MERCHANT_ACCOUNT_INFORMATION_GUI = '00'.freeze
      ID_MERCHANT_ACCOUNT_INFORMATION_KEY = '01'.freeze
      ID_MERCHANT_ACCOUNT_INFORMATION_DESCRIPTION = '02'.freeze
      ID_MERCHANT_CATEGORY_CODE = '52'.freeze
      ID_TRANSACTION_CURRENCY = '53'.freeze
      ID_TRANSACTION_AMOUNT = '54'.freeze
      ID_COUNTRY_CODE = '58'.freeze
      ID_MERCHANT_NAME = '59'.freeze
      ID_MERCHANT_CITY = '60'.freeze
      ID_ADDITIONAL_DATA_FIELD_TEMPLATE = '62'.freeze
      ID_ADDITIONAL_DATA_FIELD_TEMPLATE_TXID = '05'.freeze
      ID_CRC16 = '63'.freeze

      attr_accessor :pix_key, :description, :merchant_name, :merchant_city, :txid, :amount

      def payload
        p  = get_value(ID_PAYLOAD_FORMAT_INDICATOR, '01')
        p += get_merchant_account_information
        p += get_value(ID_MERCHANT_CATEGORY_CODE, '0000')
        p += get_value(ID_TRANSACTION_CURRENCY, '986')
        p += get_value(ID_TRANSACTION_AMOUNT, amount)
        p += get_value(ID_COUNTRY_CODE, 'BR')
        p += get_value(ID_MERCHANT_NAME, merchant_name)
        p += get_value(ID_MERCHANT_CITY, merchant_city)
        p += get_additional_data_field_template

        p + crc16(p)
      end

      private

      def get_merchant_account_information
        # dominio do banco
        gui = get_value(ID_MERCHANT_ACCOUNT_INFORMATION_GUI, 'br.gov.bcb.pix')

        #chave pix
        key = get_value(ID_MERCHANT_ACCOUNT_INFORMATION_KEY, pix_key)

        #descrição do pagamento
        payment_text = get_value(ID_MERCHANT_ACCOUNT_INFORMATION_DESCRIPTION, description)

        # valor completo da conta
        get_value ID_MERCHANT_ACCOUNT_INFORMATION, "#{gui}#{key}#{payment_text}"
      end

      def get_value(id, value)
        size = value.to_s.length.to_s.rjust(2, '0')
        "#{id}#{size}#{value}"
      end

      def get_additional_data_field_template
        #txid
        calculated_txid = get_value ID_ADDITIONAL_DATA_FIELD_TEMPLATE_TXID, txid
        get_value ID_ADDITIONAL_DATA_FIELD_TEMPLATE, calculated_txid
      end

      def crc16(raw_payload)
        p = "#{raw_payload}#{ID_CRC16}04"

        polinomio = 0x1021
        resultado = 0xFFFF

        length = p.length
        if length > 0
          offset = 0
          while offset < length
            resultado = resultado ^ (p[offset].bytes[0] << 8)

            bitwise = 0
            while bitwise < 8
              resultado = resultado << 1

              if resultado & 0x10000 != 0
                resultado = resultado ^ polinomio
              end

              resultado = resultado & 0xFFFF

              bitwise += 1
            end

            offset += 1
          end
        end

        "#{ID_CRC16}04#{resultado.to_s(16).upcase}"
      end
    end
  end
end
