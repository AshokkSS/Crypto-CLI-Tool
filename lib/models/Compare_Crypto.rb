require_relative './Crypto_Api.rb'
require_relative './Main_Menu.rb'
require_relative '../../config/environment'

class CompareCrypto
    attr_reader :loop
    attr_reader :crypto_1
    attr_reader :crypto_1_historical
    attr_reader :crypto_2
    attr_reader :crypto_2_historical
    CRYPTOAPI = CryptoAPI.new
    CRYPTOAPI_2 = CryptoAPI.new
    CLEAR = "\e[H\e[2J"
    PROMPT = TTY::Prompt.new

    def welcome_user
        puts "Welcome to Compare Crypto!"
        CRYPTOAPI.get_valid_coins
        CRYPTOAPI.get_valid_currencies
        @loop = nil
    end

    def display_mini_menu
        puts CLEAR
        MainMenu.new.show_logo
        crypto_inputs = get_crypto_inputs
        fiat_input = get_fiat_input
        puts CLEAR
        MainMenu.new.show_logo
        set_crypto_1(crypto_inputs[0],fiat_input)
        set_crypto_2(crypto_inputs[1],fiat_input)
    end

    def get_crypto_inputs
        puts "Here you can select the 2 Cryptos you would like to Compare: (Example: Bitcoin)"
        crypto_inputs = PROMPT.multi_select("Please select an option below.", CRYPTOAPI.valid_coins, max: 2, filter: true)
        return crypto_inputs
    end

    def get_fiat_input 
        prompt = TTY::Prompt.new
        puts "Here you can enter the fiat currency you would like to use: (Example: GBP)"
        fiat_input = prompt.select("Please select an option below.", CRYPTOAPI.valid_currencies, filter: true)
        return fiat_input
    end
    
    def set_crypto_1(crypto_input,fiat_input)
        @crypto_1 = CRYPTOAPI.get_crypto_price(crypto_input,fiat_input)
        @crypto_1_historical = CRYPTOAPI.get_historical_data(crypto_input,fiat_input)
        puts @crypto_1,@crypto_1_historical
    end

    def set_crypto_2(crypto_input,fiat_input)
        @crypto_2 = CRYPTOAPI.get_crypto_price(crypto_input,fiat_input)
        @crypto_2_historical = CRYPTOAPI.get_historical_data(crypto_input,fiat_input)
        puts @crypto_2,@crypto_2_historical
    end
end