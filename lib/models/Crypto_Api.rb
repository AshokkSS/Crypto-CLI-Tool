class CryptoAPI
    attr_reader :ping_response
    attr_reader :connection_status
    attr_reader :valid_coins
    attr_reader :valid_currencies
    attr_reader :price_check_values
    PING_URL = "https://api.coingecko.com/api/v3/ping"
    CRYPTO_PRICE_URL = "https://api.coingecko.com/api/v3/simple/price?ids="
    COIN_LIST_URL = 'https://api.coingecko.com/api/v3/coins/list'
    CURRENCY_LIST_URL = "https://api.coingecko.com/api/v3/simple/supported_vs_currencies"
    PRICE_CHECK_URL = "https://api.coingecko.com/api/v3/simple/price?ids="
    CLEAR = "\e[H\e[2J"

    def ping_api
        uri = URI(PING_URL)
        ping_response = Net::HTTP.get_response(uri)
        if ping_response.is_a?(Net::HTTPSuccess)
            @connection_status = {response_object: ping_response, message: "Connected to API"}
        else
            @connection_status = {response_object: ping_response, message:"Unable to connect to API, Please close and reopen."}
        end
    end

    def get_valid_coins
        uri = URI(COIN_LIST_URL)
        res = Net::HTTP.get_response(uri)
        parsed_json = JSON.parse(res.body)
        @valid_coins = []
        parsed_json.each do |hash|
            @valid_coins << hash["id"]
        end
    end

    def get_valid_currencies
        uri = URI(CURRENCY_LIST_URL)
        res = Net::HTTP.get_response(uri)
        @valid_currencies = JSON.parse(res.body) 
    end

    def get_crypto_price (crypto_input, fiat_input)
        url = PRICE_CHECK_URL
        url << "#{crypto_input}&vs_currencies=#{fiat_input}&include_market_cap=true&include_24hr_vol=true&include_24hr_change=true"
        uri = URI(url)
        res = Net::HTTP.get_response(uri)
        parsed_json = JSON.parse(res.body)
        fiat_price = parsed_json [crypto_input][fiat_input]
        mcap = parsed_json [crypto_input]["#{fiat_input}_market_cap"].to_s
        hr_vol = parsed_json [crypto_input]["#{fiat_input}_24h_vol"].to_s
        hr_change = parsed_json [crypto_input]["#{fiat_input}_24h_change"]
        @price_check_values = [crypto_input, fiat_input,fiat_price, mcap, hr_vol, hr_change]
    end

    def show_connection_status
        ping_api 
        print_connection_response
    end

    def print_connection_response
        if @connection_status[:response_object].is_a?(Net::HTTPSuccess)
            connected_box_success
        else
            connected_box_failure
        end
    end

    def connected_box_success
        box = TTY::Box.success(@connection_status[:message])
        print box
        sleep 2
        puts CLEAR
    end

    def connected_box_failure
        box = TTY::Box.error(@connection_status[:message])
        print box
        sleep 2
        puts CLEAR
    end    
end