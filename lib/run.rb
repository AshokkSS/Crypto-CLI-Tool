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

def get_crypto_input 
    puts "Here you can enter the name of the Crypto you would like to price check: (Example: Bitcoin)"
    crypto_input = gets.chomp
    uri = URI('https://api.coingecko.com/api/v3/coins/list')
    res = Net::HTTP.get_response(uri)
    parsed_json = JSON.parse(res.body)
    results = []
    parsed_json.each do |hash|
        results << hash["id"]
    end
    puts "Invalid fiat input. Here is a list of valid Currencies you can input " unless results.include? crypto_input
    return crypto_input
end

def get_fiat_input
    puts "Here you can enter the fiat currency you would like to use: (Example: GBP)"
    fiat_input = gets.chomp
    fiat_input = "gbp" if fiat_input.empty?
    supported_currency = "https://api.coingecko.com/api/v3/simple/supported_vs_currencies"
    uri = URI(supported_currency)
    res = Net::HTTP.get_response(uri)
    parsed_json = JSON.parse(res.body)
    puts "Invalid fiat input. Here is a list of valid Currencies you can input #{parsed_json}" unless parsed_json.include? fiat_input
    return fiat_input
end

def get_crypto_price (crypto_input, fiat_input)
    url = "https://api.coingecko.com/api/v3/simple/price?ids="
    url << "#{crypto_input}&vs_currencies=#{fiat_input}&include_market_cap=true&include_24hr_vol=true&include_24hr_change=true"
    uri = URI(url)
    res = Net::HTTP.get_response(uri)
    parsed_json = JSON.parse(res.body)
    puts res.body
end