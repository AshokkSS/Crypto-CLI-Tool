class CompareCrypto
    attr_reader :loop
    attr_reader :crypto_1
    attr_reader :crypto_1_historical
    attr_reader :crypto_2
    attr_reader :crypto_2_historical

    CRYPTOAPI = CryptoAPI.new
    CLEAR = "\e[H\e[2J"
    PROMPT = TTY::Prompt.new

    def welcome_user
        puts "Welcome to Compare Crypto!"
        @loop = nil
        display_mini_menu
    end

    def display_mini_menu
        puts CLEAR
        MainMenu.new.show_logo
        crypto_inputs = get_crypto_inputs
        fiat_input = get_fiat_input
        puts CLEAR
        MainMenu.new.show_logo
        @crypto_1 = CRYPTOAPI.get_crypto_price(crypto_inputs[0],fiat_input)
        @crypto_1_historical = CRYPTOAPI.get_historical_data(crypto_inputs[0],fiat_input)
        # calculate_historical_change(crypto_inputs[0],fiat_input,@crypto_1,@crypto_1_historical)
        # @crypto_2 = CRYPTOAPI.get_crypto_price(crypto_inputs[1],fiat_input)
        # @crypto_2_historical = CRYPTOAPI.get_historical_data(crypto_inputs[1],fiat_input)
        # calculate_historical_change(crypto_inputs[1],fiat_input,@crypto_2,@crypto_2_historical)
        #calculate_historical_change(crypto_inputs[1],fiat_input,@crypto_2,@crypto_2_historical)
        puts @crypto_1,@crypto_1_historical
        # puts @crypto_2,@crypto_2_historical
        
    end

    def calculate_historical_change(crypto_input,fiat_input,crypto,crypto_historical)
        current_price = crypto[2]
        price_change_14d = ((current_price - crypto_historical[0])/crypto_historical[0])*100
        price_change_7d = ((current_price - crypto_historical[1])/crypto_historical[1])*100
        puts(crypto_input,fiat_input,price_change_7d,price_change_14d,crypto,crypto_historical)
    end

    def display_table(crypto_input,fiat_input,price_change_7d,price_change_14d,crypto,crypto_historical)
        values = crypto
        historical_values = crypto_historical
        puts "Showing Live stats for: #{(crypto_input).upcase} in #{(fiat_input).upcase}"
        values[5].positive? == true ? values [5] = "+#{values[5]}%".to_s.green : values [5] = "#{values[5]}%".to_s.red
        price_change_7d.positive? == true ? price_change_7d = "+#{price_change_7d}%".to_s.green : price_change_7d = "#{price_change_7d}%".to_s.red
        price_change_14d.positive? == true ? price_change_14d = "+#{price_change_14d}%".to_s.green : price_change_14d = "#{price_change_14d}%".to_s.red
        price_check_table = TTY::Table.new(["Price","Market Cap","24 Hours Volume","Price 1D Ago"," 1 Day Change","Price 7D Ago","7 Day Change","Price 14D Ago", "14 Day Change"], [[values[2],values[3],values[4],historical_values[2],values[5],historical_values[1],price_change_7d,historical_values[0],price_change_14d]])
        puts price_check_table.render(:unicode,padding: [1,2,1,2])
        # values[0].upcase!
        # values[1].upcase!
        # puts "How much different amounts of #{values[0]} are worth:"
        # multiplier_table = TTY::Table.new(["Number of Coins","Value"], [["1 #{values[0]}","#{values[2]} #{values[1]}"],["10 #{values[0]}'s","#{values[2]*10} #{values[1]}"],["100 #{values[0]}'s","#{values[2]*100} #{values[1]}"],["500 #{values[0]}'s","#{values[2]*500} #{values[1]}"],["1000 #{values[0]}'s","#{values[2]*1000} #{values[1]}"]])
        # puts multiplier_table.render(:unicode,padding: [1,2,1,2])
    end

    def calculate_historical_change2(crypto_input,fiat_input,crypto,crypto_historical)
        current_price = crypto[2]
        price_change_14d = ((current_price - crypto_historical[0])/crypto_historical[0])*100
        price_change_7d = ((current_price - crypto_historical[1])/crypto_historical[1])*100
        puts(crypto_input,fiat_input,price_change_7d,price_change_14d,crypto,crypto_historical)
    end

    def display_table2(crypto_input,fiat_input,price_change_7d,price_change_14d,crypto,crypto_historical)
        values = crypto
        historical_values = crypto_historical
        puts "Showing Live stats for: #{(crypto_input).upcase} in #{(fiat_input).upcase}"
        values[5].positive? == true ? values [5] = "+#{values[5]}%".to_s.green : values [5] = "#{values[5]}%".to_s.red
        price_change_7d.positive? == true ? price_change_7d = "+#{price_change_7d}%".to_s.green : price_change_7d = "#{price_change_7d}%".to_s.red
        price_change_14d.positive? == true ? price_change_14d = "+#{price_change_14d}%".to_s.green : price_change_14d = "#{price_change_14d}%".to_s.red
        price_check_table = TTY::Table.new(["Price","Market Cap","24 Hours Volume","Price 1D Ago"," 1 Day Change","Price 7D Ago","7 Day Change","Price 14D Ago", "14 Day Change"], [[values[2],values[3],values[4],historical_values[2],values[5],historical_values[1],price_change_7d,historical_values[0],price_change_14d]])
        puts price_check_table.render(:unicode,padding: [1,2,1,2])
        # values[0].upcase!
        # values[1].upcase!
        # puts "How much different amounts of #{values[0]} are worth:"
        # multiplier_table = TTY::Table.new(["Number of Coins","Value"], [["1 #{values[0]}","#{values[2]} #{values[1]}"],["10 #{values[0]}'s","#{values[2]*10} #{values[1]}"],["100 #{values[0]}'s","#{values[2]*100} #{values[1]}"],["500 #{values[0]}'s","#{values[2]*500} #{values[1]}"],["1000 #{values[0]}'s","#{values[2]*1000} #{values[1]}"]])
        # puts multiplier_table.render(:unicode,padding: [1,2,1,2])
    end

    def get_crypto_inputs
        CRYPTOAPI.get_valid_coins
        puts "Here you can select the 2 Cryptos you would like to Compare: (Example: Bitcoin)"
        crypto_inputs = PROMPT.multi_select("Please select an option below.", CRYPTOAPI.valid_coins, max: 2, filter: true)
        return crypto_inputs
        # puts crypto_inputs[0]
        # puts crypto_inputs [1]
    end

    def get_fiat_input 
        CRYPTOAPI.get_valid_currencies
        prompt = TTY::Prompt.new
        puts "Here you can enter the fiat currency you would like to use: (Example: GBP)"
        fiat_input = prompt.select("Please select an option below.", CRYPTOAPI.valid_currencies, filter: true)
        return fiat_input
    end
end