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
                crypto_input = get_crypto_input
                fiat_input = get_fiat_input
                puts CLEAR
                show_logo
                get_crypto_price(crypto_input, fiat_input)
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
