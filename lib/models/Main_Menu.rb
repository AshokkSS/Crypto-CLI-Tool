require_relative '../../config/environment'
require_relative './Crypto_Api.rb'


class Main_Menu
    CLEAR = "\e[H\e[2J"
    PROMPT = TTY::Prompt.new
    OPTIONS =  %w(Price_Check Compare_Cryptos My_Portfolio Close)
    CRYPTOAPI = CryptoAPI.new
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

    def get_user_input(result)
        case result
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
        CRYPTOAPI.show_connection_status
    end

    def display_main_menu
        $result = PROMPT.select("Please select an option below.", OPTIONS)
        get_user_input($result)
    end
end