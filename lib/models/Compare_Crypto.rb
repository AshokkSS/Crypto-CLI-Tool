require_relative './Crypto_Api.rb'
require_relative './Main_Menu.rb'
require_relative '../../config/environment'

class CompareCrypto
    attr_reader :loop
    attr_reader :crypto
    attr_reader :table
    CRYPTOAPI = CryptoAPI.new
    CLEAR = "\e[H\e[2J"
    PROMPT = TTY::Prompt.new

    def welcome_user
        puts "Welcome to Compare Crypto!"
        CRYPTOAPI.get_valid_coins
        CRYPTOAPI.get_valid_currencies
        @loop = nil
        @table = TTY::Table.new(header: ["Coin","Price","Market Cap","24 Hours Volume","Price 1D Ago"," 1 Day Change","Price 7D Ago","7 Day Change","Price 14D Ago", "14 Day Change"],rows: [])
        @crypto = []
    end

    def display_mini_menu
        puts CLEAR
        MainMenu.new.show_logo
        crypto_inputs = get_crypto_inputs
        fiat_input = get_fiat_input
        puts CLEAR
        MainMenu.new.show_logo
        crypto_inputs.each do |n|
            set_crypto(n,fiat_input)
        end
        @crypto.each do |n|
            calculate_historical_change(n[0][0],n[0][1],n[0],n[1])
        end
        time2 = Time.now
        puts "Comparing #{crypto_inputs.length()} cryptos in #{fiat_input.upcase} at #{time2.inspect}"
        puts @table.render(:unicode,padding: [0,1])
    end

    def get_crypto_inputs
        puts "Here you can select the 2 Cryptos you would like to Compare: (Example: Bitcoin)"
        crypto_inputs = PROMPT.multi_select("Please select an option below.", CRYPTOAPI.valid_coins, min: 2, filter: true)
        return crypto_inputs
    end

    def get_fiat_input 
        prompt = TTY::Prompt.new
        puts "Here you can enter the fiat currency you would like to use: (Example: GBP)"
        fiat_input = prompt.select("Please select an option below.", CRYPTOAPI.valid_currencies, filter: true)
        return fiat_input
    end
    
    def set_crypto(crypto_input,fiat_input)
        @crypto << [CRYPTOAPI.get_crypto_price(crypto_input,fiat_input),CRYPTOAPI.get_historical_data(crypto_input,fiat_input)]
    end

    def calculate_historical_change(crypto_input,fiat_input,crypto,crypto_historical)
        current_price = crypto[2]
        price_change_14d = (((current_price - crypto_historical[0])/crypto_historical[0])*100).round(3)
        price_change_7d = (((current_price - crypto_historical[1])/crypto_historical[1])*100).round(3)
        set_table(crypto_input,fiat_input,price_change_7d,price_change_14d,crypto,crypto_historical)
    end

    def set_table(crypto_input,fiat_input,price_change_7d,price_change_14d,crypto,crypto_historical)
        values = crypto
        historical_values = crypto_historical
        values[5].positive? == true ? values [5] = "▲ +#{values[5]}%".to_s.green : values [5] = "▼ #{values[5]}%".to_s.red
        price_change_7d.positive? == true ? price_change_7d = "▲ +#{price_change_7d}%".to_s.green : price_change_7d = "▼ #{price_change_7d}%".to_s.red
        price_change_14d.positive? == true ? price_change_14d = "▲ +#{price_change_14d}%".to_s.green : price_change_14d = "▼ #{price_change_14d}%".to_s.red
        @table << :separator << [(crypto_input).upcase,values[2],values[3],values[4],historical_values[2],values[5],historical_values[1],price_change_7d,historical_values[0],price_change_14d]
    end
end