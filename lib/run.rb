require_relative '../config/environment'


class Main_Menu
    CLEAR = "\e[H\e[2J"
    PROMPT = TTY::Prompt.new
    OPTIONS =  %w(Price_Check Compare_Cryptos My_Portfolio Close)
    def show_logo
        puts "
        ░█████╗░██████╗░██╗░░░██╗██████╗░████████╗░█████╗░  ░█████╗░██╗░░░░░██╗  ████████╗░█████╗░░█████╗░██╗░░░░░
        ██╔══██╗██╔══██╗╚██╗░██╔╝██╔══██╗╚══██╔══╝██╔══██╗  ██╔══██╗██║░░░░░██║  ╚══██╔══╝██╔══██╗██╔══██╗██║░░░░░
        ██║░░╚═╝██████╔╝░╚████╔╝░██████╔╝░░░██║░░░██║░░██║  ██║░░╚═╝██║░░░░░██║  ░░░██║░░░██║░░██║██║░░██║██║░░░░░
        ██║░░██╗██╔══██╗░░╚██╔╝░░██╔═══╝░░░░██║░░░██║░░██║  ██║░░██╗██║░░░░░██║  ░░░██║░░░██║░░██║██║░░██║██║░░░░░
        ╚█████╔╝██║░░██║░░░██║░░░██║░░░░░░░░██║░░░╚█████╔╝  ╚█████╔╝███████╗██║  ░░░██║░░░╚█████╔╝╚█████╔╝███████╗
        ░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░░░░░░░╚═╝░░░░╚════╝░  ░╚════╝░╚══════╝╚═╝  ░░░╚═╝░░░░╚════╝░░╚════╝░╚══════╝
        
        
        
        
        ".colorize(:light_magenta)
    end

    def startup
        loading_menu
        $quit = nil
        show_logo
        
    end

    def get_user_input
        case $result
        when "Close"
            puts CLEAR
            $quit = true
        when "Price_Check"
            puts "Welcome to Price Check"
        when "Compare_Cryptos"
            puts "Welcome to Compare Cryptos"
        when "My_Portfolio"
            puts "Welcome to My Portfolio"
        end
    end

    def loading_menu
        puts CLEAR
        Crypto_API.new.ping_api
        
    end
    
    
    
    def display_main_menu
        $result = PROMPT.select("Please select an option below.", OPTIONS)
        get_user_input
    end



end

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