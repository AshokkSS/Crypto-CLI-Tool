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