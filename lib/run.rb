require_relative '../config/environment'
CLEAR = "\e[H\e[2J"
PROMPT = TTY::Prompt.new
OPTIONS =  %w(Price_Check Compare_Cryptos My_Portfolio Close)

def capture_stdout(&blk)
    old = $stdout
    $stdout = fake = StringIO.new
    blk.call
    fake.string
  ensure
    $stdout = old
  end

def startup
    loading_menu
    $quit = nil
    show_logo
    while !$quit
     display_main_menu
    end
end

def display_main_menu
    puts "my message"
    #$result = PROMPT.select("Please select an option below.", OPTIONS)
    #get_user_input
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

