class CryptoAPI
    attr_reader :ping_response
    attr_reader :connection_status
    PING_URL = "https://api.coingecko.com/api/v3/ping"
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