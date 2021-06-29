# frozen_string_literal: true

require 'rqrcode'

module QrcodePixRuby
  class Payload
    ID_PAYLOAD_FORMAT_INDICATOR                 = '00'
    ID_POINT_OF_INITIATION_METHOD               = '01'
    ID_MERCHANT_ACCOUNT_INFORMATION             = '26'
    ID_MERCHANT_ACCOUNT_INFORMATION_GUI         = '00'
    ID_MERCHANT_ACCOUNT_INFORMATION_KEY         = '01'
    ID_MERCHANT_ACCOUNT_INFORMATION_DESCRIPTION = '02'
    ID_MERCHANT_CATEGORY_CODE                   = '52'
    ID_TRANSACTION_CURRENCY                     = '53'
    ID_TRANSACTION_AMOUNT                       = '54'
    ID_COUNTRY_CODE                             = '58'
    ID_MERCHANT_NAME                            = '59'
    ID_MERCHANT_CITY                            = '60'
    ID_POSTAL_CODE                              = '61'
    ID_ADDITIONAL_DATA_FIELD_TEMPLATE           = '62'
    ID_ADDITIONAL_DATA_FIELD_TEMPLATE_TXID      = '05'
    ID_CRC16                                    = '63'

    attr_accessor :pix_key,
                  :repeatable,
                  :currency,
                  :country_code,
                  :description,
                  :postal_code,
                  :merchant_name,
                  :merchant_city,
                  :transaction_id,
                  :amount

    def payload
      p = ''

      p += emv(ID_PAYLOAD_FORMAT_INDICATOR, '01')
      p += emv_repeatable
      p += emv_merchant
      p += emv(ID_MERCHANT_CATEGORY_CODE, '0000')
      p += emv(ID_TRANSACTION_CURRENCY, currency || '986')
      p += emv(ID_TRANSACTION_AMOUNT, amount) if amount
      p += emv(ID_COUNTRY_CODE, country_code || 'BR')
      p += emv(ID_MERCHANT_NAME, merchant_name)
      p += emv(ID_MERCHANT_CITY, merchant_city)
      p += emv(ID_POSTAL_CODE, postal_code) if postal_code
      p += emv_additional_data

      p + crc16(p)
    end

    def base64
      ::RQRCode::QRCode.new(payload).as_png(
        bit_depth: 1,
        border_modules: 0,
        color_mode: 0,
        color: 'black',
        file: nil,
        fill: 'white',
        module_px_size: 6,
        resize_exactly_to: false,
        resize_gte_to: false
      ).to_data_url
    end

    private

    def emv(id, value)
      size = value.to_s.length.to_s.rjust(2, '0')
      "#{id}#{size}#{value}"
    end

    def emv_repeatable
      emv(ID_POINT_OF_INITIATION_METHOD, repeatable ? '11' : '12')
    end

    def emv_merchant
      merchant_gui         = emv(ID_MERCHANT_ACCOUNT_INFORMATION_GUI, 'BR.GOV.BCB.PIX')
      merchant_pix_key     = emv(ID_MERCHANT_ACCOUNT_INFORMATION_KEY, pix_key)
      merchant_description = emv(ID_MERCHANT_ACCOUNT_INFORMATION_DESCRIPTION, description) if description
      emv(ID_MERCHANT_ACCOUNT_INFORMATION, "#{merchant_gui}#{merchant_pix_key}#{merchant_description}")
    end

    def emv_additional_data
      txid = emv(ID_ADDITIONAL_DATA_FIELD_TEMPLATE_TXID, transaction_id || '***')
      emv(ID_ADDITIONAL_DATA_FIELD_TEMPLATE, txid)
    end

    def crc16(text)
      extended_payload = "#{text}#{ID_CRC16}04"
      extended_payload_length = extended_payload.length
      polynomial = 0x1021
      result = 0xFFFF

      if extended_payload_length.positive?
        offset = 0

        while offset < extended_payload_length
          result ^= extended_payload[offset].bytes[0] << 8
          bitwise = 0

          while bitwise < 8
            result <<= 1
            result ^= polynomial if result & 0x10000 != 0
            result &= 0xFFFF
            bitwise += 1
          end

          offset += 1
        end
      end

      "#{ID_CRC16}04#{result.to_s(16).upcase}"
    end
  end
end
