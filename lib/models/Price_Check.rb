require_relative './Crypto_Api.rb'
require_relative './Main_Menu.rb'
require_relative '../../config/environment'

class PriceCheck
    CRYPTOAPI = CryptoAPI.new
    #MAINMENU = MainMenu.new
    CLEAR = "\e[H\e[2J"

    def welcome_user
        puts "Welcome to Price Check!"
    end

    def display_mini_menu
        puts CLEAR
        MainMenu.new.show_logo
        crypto_input = get_crypto_input
        fiat_input = get_fiat_input
        puts CLEAR
        MainMenu.new.show_logo
        CRYPTOAPI.get_crypto_price(crypto_input,fiat_input)
        display_table(crypto_input,fiat_input)
    end

    def display_table(crypto_input, fiat_input)
        values = CRYPTOAPI.price_check_values
        puts "Showing Live stats for: #{(crypto_input).upcase} in #{(fiat_input).upcase}"
        if values[5].positive? == true
            values [5] = "+#{values[5]}%".to_s.green
            table = TTY::Table.new(["Price","Market Cap","24 Hours Volume"," 24 Hours Change"], [[values[2],values[3],values[4],values[5]]])
        else
            values [5] = "#{values[5]}%".to_s.red
            table = TTY::Table.new(["Price","Market Cap","24 Hours Volume"," 24 Hours Change"], [[values[2],values[3],values[4],values[5]]])
        end
        puts table.render(:unicode,padding: [1,2,1,2])
        puts "1 #{values[0]} is worth #{values[2]} #{values[1].upcase}."
        puts "10 #{values[0]}'s are worth #{values[2]*10} #{values[1].upcase}."
        puts "100 #{values[0]}'s are worth #{values[2]*100} #{values[1].upcase}."
        puts "500 #{values[0]}'s are worth #{values[2]*500} #{values[1].upcase}."
        puts "1000 #{values[0]}'s are worth #{values[2]*1000} #{values[1].upcase}."
    end

    def get_crypto_input 
        CRYPTOAPI.get_valid_coins
        prompt = TTY::Prompt.new 
        puts "Here you can enter the name of the Crypto you would like to price check: (Example: Bitcoin)"
        crypto_input = prompt.select("Please select an option below.", CRYPTOAPI.valid_coins, filter: true)
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