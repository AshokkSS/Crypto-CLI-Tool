require_relative '../config/environment'
CLEAR = "\e[H\e[2J"

def loading_menu
    puts CLEAR
    bar = TTY::ProgressBar.new("Connecting to API [:bar]", total: 10)
    10.times do
        sleep(0.1)
        bar.advance 
        uri = URI('https://api.coingecko.com/api/v3/ping')
        res = Net::HTTP.get_response(uri)
        bar.finish if res.is_a?(Net::HTTPSuccess)
    end
    puts CLEAR
    box = TTY::Box.success("Connected to API")
    print box
    sleep 2
    puts CLEAR
end
   
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