require 'json'
require 'net/http'

# Method to get currency exchange rate from API
def get_exchange_rate(base_currency, target_currency)
  app_id = "ea9a7476a66d4537958bf6b46010c3ac"
  url = "https://open.er-api.com/v6/latest/#{base_currency}"

  uri = URI(url)
  response = Net::HTTP.get(uri)
  data = JSON.parse(response)

  exchange_rate = data["rates"][target_currency]
  return exchange_rate
end

# Method for currency conversion
def convert_currency(amount, exchange_rate)
  return amount * exchange_rate
end

# Main function
def main()
  begin
    puts "Enter the amount to convert:"
    amount = Float(gets.chomp)

    puts "Enter the source currency (for example, USD):"
    base_currency = gets.chomp.upcase

    puts "Enter the currency to convert (for example, EUR):"
    target_currency = gets.chomp.upcase

    # Checking that the entered currencies exist in the API
    unless CURRENCIES.include?(base_currency) && CURRENCIES.include?(target_currency)
      raise StandardError, "The currency specified is incorrect. Please enter correct currency codes."
    end

    exchange_rate = get_exchange_rate(base_currency, target_currency)

    if exchange_rate.nil?
      puts "Failed to get exchange rate. Please check the entered currencies and try again."
    else
      converted_amount = convert_currency(amount, exchange_rate)
      puts "#{amount} #{base_currency} = #{converted_amount} #{target_currency}"
    end
  rescue ArgumentError
    puts "Error: incorrect amount to convert. Enter a numeric value."
  rescue StandardError => e
    puts "An error has occurred: #{e.message}"
  end
end

# Array of available currencies
CURRENCIES = [
  "AED", "AFN", "ALL", "AMD", "ANG", "AOA", "ARS", "AUD", "AWG", "AZN",
  "BAM", "BBD", "BDT", "BGN", "BHD", "BIF", "BMD", "BND", "BOB", "BRL",
  "BSD", "BTN", "BWP", "BYN", "BZD", "CAD", "CDF", "CHF", "CLP", "CNY",
  "COP", "CRC", "CUP", "CVE", "CZK", "DJF", "DKK", "DOP", "DZD", "EGP",
  "ERN", "ETB", "EUR", "FJD", "FKP", "FOK", "GBP", "GEL", "GGP", "GHS",
  "GIP", "GMD", "GNF", "GTQ", "GYD", "HKD", "HNL", "HRK", "HTG", "HUF",
  "IDR", "ILS", "IMP", "INR", "IQD", "IRR", "ISK", "JEP", "JMD", "JOD",
  "JPY", "KES", "KGS", "KHR", "KID", "KMF", "KPW", "KRW", "KWD", "KYD",
  "KZT", "LAK", "LBP", "LKR", "LRD", "LSL", "LYD", "MAD", "MDL", "MGA",
  "MKD", "MMK", "MNT", "MOP", "MRU", "MUR", "MVR", "MWK", "MXN", "MYR",
  "MZN", "NAD", "NGN", "NIO", "NOK", "NPR", "NZD", "OMR", "PAB", "PEN",
  "PGK", "PHP", "PKR", "PLN", "PYG", "QAR", "RON", "RSD", "RUB", "RWF",
  "SAR", "SBD", "SCR", "SDG", "SEK", "SGD", "SHP", "SLL", "SOS", "SRD",
  "SSP", "STN", "SYP", "SZL", "THB", "TJS", "TMT", "TND", "TOP", "TRY",
  "TTD", "TVD", "TWD", "TZS", "UAH", "UGX", "USD", "UYU", "UZS", "VES",
  "VND", "VUV", "WST", "XAF", "XCD", "XDR", "XOF", "XPF", "YER", "ZAR",
  "ZMW", "ZWD"
]

main()
