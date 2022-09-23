require_relative '../config/environment'
require_relative '../lib/run'

loading_menu
API_URL = "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=gbp"
quit = nil
option_quit = nil
show_logo
while !quit
    prompt = TTY::Prompt.new
    options =  %w(Price_Check Compare_Cryptos My_Portfolio Close)
    exit_options =  %w(Input_Another Close)
    result = prompt.select("Please select an option below.", options, filter: true)
    case result
    when "Close"
        puts CLEAR
        quit = true
    when "Price_Check"
        option_quit = nil
        puts CLEAR
            while !option_quit
                show_logo
                puts "Here you can enter the name of the Crypto you would like to price check: (Example: Bitcoin)"
                crypto_input = gets.chomp
                puts "Here you can enter the fiat currency you would like to use: (Example: GBP)"
                fiat_input = gets.chomp
                fiat_input = "gbp" if fiat_input.empty?
                supported_currency = "https://api.coingecko.com/api/v3/simple/supported_vs_currencies"
                uri = URI(supported_currency)
                res = Net::HTTP.get_response(uri)
                parsed_json = JSON.parse(res.body)
                if parsed_json.include? fiat_input
                    puts "Valid fiat input." 
                else 
                    puts "Invalid fiat input. Here is a list of valid Currencies you can input #{parsed_json}"
                end
                url = "https://api.coingecko.com/api/v3/simple/price?ids="
                url << "#{crypto_input}&vs_currencies=#{fiat_input}&include_market_cap=true&include_24hr_vol=true&include_24hr_change=true"
                uri = URI(url)
                res = Net::HTTP.get_response(uri)
                parsed_json = JSON.parse(res.body)
                puts res.body
                option_result = prompt.select("Please select an option below.", exit_options, filter: true)
                case option_result
                when "Input_Another"
                    puts CLEAR
                when "Close"
                    option_quit = true
                    puts CLEAR
                    show_logo
                end
            end
    when "Compare_Cryptos"
        option_quit = nil
        puts CLEAR
            while !option_quit
                show_logo
                puts "Welcome to Compare Cryptos"
                option_result = prompt.select("Please select an option below.", exit_options, filter: true)
                case option_result
                when "Input_Another"
                    puts CLEAR
                when "Close"
                    option_quit = true
                    puts CLEAR
                    show_logo
                end
            end
    when "My_Portfolio"
        option_quit = nil
        puts CLEAR
            while !option_quit
                show_logo
                puts "Welcome to My Portfolio"
                option_result = prompt.select("Please select an option below.", exit_options, filter: true)
                case option_result
                when "Input_Another"
                    puts CLEAR
                when "Close"
                    option_quit = true
                    puts CLEAR
                    show_logo
                end
            end
    end
end
