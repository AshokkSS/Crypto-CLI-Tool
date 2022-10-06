require_relative './Crypto_Api.rb'
require_relative './Main_Menu.rb'
require_relative '../../config/environment'

class PriceCheck
    attr_reader :loop
    CRYPTOAPI = CryptoAPI.new
    CLEAR = "\e[H\e[2J"
    PROMPT = TTY::Prompt.new

    def welcome_user
        puts "Welcome to Price Check!"
        @loop = nil
    end

    def display_mini_menu
        while !@loop
            puts CLEAR
            MainMenu.new.show_logo
            crypto_input = get_crypto_input
            fiat_input = get_fiat_input
            puts CLEAR
            MainMenu.new.show_logo
            CRYPTOAPI.get_crypto_price(crypto_input,fiat_input)
            display_table(crypto_input,fiat_input)
        end
    end

    def display_table(crypto_input, fiat_input)
        values = CRYPTOAPI.price_check_values
        puts "Showing Live stats for: #{(crypto_input).upcase} in #{(fiat_input).upcase}"
        if values[5].positive? == true
            values [5] = "+#{values[5]}%".to_s.green
        else
            values [5] = "#{values[5]}%".to_s.red
        end
        price_check_table = TTY::Table.new(["Price","Market Cap","24 Hours Volume"," 24 Hours Change"], [[values[2],values[3],values[4],values[5]]])
        puts price_check_table.render(:unicode,padding: [1,2,1,2])
        values[0].upcase!
        values[1].upcase!
        puts "How much different amounts of #{values[0]} are worth:"
        multiplier_table = TTY::Table.new(["Number of Coins","Value"], [["1 #{values[0]}","#{values[2]} #{values[1]}"],["10 #{values[0]}'s","#{values[2]*10} #{values[1]}"],["100 #{values[0]}'s","#{values[2]*100} #{values[1]}"],["500 #{values[0]}'s","#{values[2]*500} #{values[1]}"],["1000 #{values[0]}'s","#{values[2]*1000} #{values[1]}"]])
        puts multiplier_table.render(:unicode,padding: [1,2,1,2])
        display_exit_options
    end

    def display_exit_options
        puts ""
        option = PROMPT.select("Please select an option below.", %w(View_Another_Crypto Close))
        case option
        when "View_Another_Crypto"  
            puts CLEAR
        when "Close"
            @loop = true
            puts CLEAR
        end
    end

    def get_crypto_input 
        CRYPTOAPI.get_valid_coins
        puts "Here you can enter the name of the Crypto you would like to price check: (Example: Bitcoin)"
        crypto_input = PROMPT.select("Please select an option below.", CRYPTOAPI.valid_coins, filter: true)
        return crypto_input
    end

    def get_fiat_input 
        CRYPTOAPI.get_valid_currencies
        prompt = TTY::Prompt.new
        puts "Here you can enter the fiat currency you would like to use: (Example: GBP)"
        fiat_input = prompt.select("Please select an option below.", CRYPTOAPI.valid_currencies, filter: true)
        return fiat_input
    end
end