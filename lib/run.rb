require_relative '../config/environment'
CLEAR = "\e[H\e[2J"
def red;            "\e[31m#{self}\e[0m" end
def green;          "\e[32m#{self}\e[0m" end
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
    prompt = TTY::Prompt.new 
    uri = URI('https://api.coingecko.com/api/v3/coins/list')
    res = Net::HTTP.get_response(uri)
    parsed_json = JSON.parse(res.body)
    results = []
    parsed_json.each do |hash|
        results << hash["id"]
    end
    puts "Here you can enter the name of the Crypto you would like to price check: (Example: Bitcoin)"
    crypto_input = prompt.select("Please select an option below.", results, filter: true)
    return crypto_input
end

def get_fiat_input
    prompt = TTY::Prompt.new
    supported_currency = "https://api.coingecko.com/api/v3/simple/supported_vs_currencies"
    uri = URI(supported_currency)
    res = Net::HTTP.get_response(uri)
    parsed_json = JSON.parse(res.body)
    puts "Here you can enter the fiat currency you would like to use: (Example: GBP)"
    fiat_input = prompt.select("Please select an option below.", parsed_json, filter: true)
    fiat_input = "gbp" if fiat_input.empty?
    return fiat_input
end

def get_crypto_price (crypto_input, fiat_input)
    url = "https://api.coingecko.com/api/v3/simple/price?ids="
    url << "#{crypto_input}&vs_currencies=#{fiat_input}&include_market_cap=true&include_24hr_vol=true&include_24hr_change=true"
    uri = URI(url)
    res = Net::HTTP.get_response(uri)
    parsed_json = JSON.parse(res.body)
    fiat_price = parsed_json [crypto_input][fiat_input]
    #fiat_price << " #{fiat_input}"
    mcap = parsed_json [crypto_input]["#{fiat_input}_market_cap"].to_s
   # mcap << " #{fiat_input}"
    hr_vol = parsed_json [crypto_input]["#{fiat_input}_24h_vol"].to_s
   # hr_vol << " #{fiat_input}"
    hr_change = parsed_json [crypto_input]["#{fiat_input}_24h_change"]
    if hr_change.positive?() == true
        hr_change = "+#{hr_change}%".to_s.green
    else
        hr_change = "#{hr_change}%".to_s.red
    end
    puts "Showing Live stats for: #{(crypto_input).upcase} in #{(fiat_input).upcase}"
    table = TTY::Table.new(["Price","Market Cap","24 Hours Volume"," 24 Hours Change"], [[fiat_price, mcap, hr_vol, hr_change]])
    puts table.render(:unicode,padding: [1,2,1,2])


end