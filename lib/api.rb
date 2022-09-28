class Crypto_API
    PING_URL = "https://api.coingecko.com/api/v3/ping"
    CLEAR = "\e[H\e[2J"
    def ping_api
        uri = URI(PING_URL)
        res = Net::HTTP.get_response(uri)
        if res.is_a?(Net::HTTPSuccess)
            connected_box_success
        else
            connected_box_failure
        end
    end

    def connected_box_success
        box = TTY::Box.success("Connected to API")
        print box
        sleep 2
        puts CLEAR
    end

    def connected_box_failure
        box = TTY::Box.error("Unable to connect to API, Please close and reopen.")
        print box
        sleep 2
        puts CLEAR
    end    
end