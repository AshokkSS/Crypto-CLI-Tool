require_relative '../../config/environment'
require_relative './Crypto_Api.rb'
require_relative './Price_Check.rb'
require_relative './Compare_Crypto.rb'
require_relative './My_Portfolio.rb'


class MainMenu
    attr_reader :quit_loop
    CLEAR = "\e[H\e[2J"
    PROMPT = TTY::Prompt.new
    OPTIONS =  %w(Price_Check Compare_Cryptos My_Portfolio Close)
    CRYPTOAPI = CryptoAPI.new
    PRICECHECK = PriceCheck.new
    COMPARECRYPTO = CompareCrypto.new
    MYPORTFOLIO = MyPortfolio.new
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
        @quit_loop = nil
        show_logo
    end

    def get_user_input(result)
        case result
        when "Close"
            puts CLEAR
            @quit_loop = true
        when "Price_Check"
            PRICECHECK.welcome_user
            PRICECHECK.display_mini_menu
        when "Compare_Cryptos"
            COMPARECRYPTO.welcome_user
        when "My_Portfolio"
            MYPORTFOLIO.welcome_user
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