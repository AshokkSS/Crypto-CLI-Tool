require_relative '../config/environment'
require_relative '../lib/run'

loading_menu
quit = nil
show_logo
while !quit
    prompt = TTY::Prompt.new
    options =  %w(Price_Check Compare_Cryptos My_Portfolio Close)
    result = prompt.select("Please select an option below.", options, filter: true)
    case result
    when "Close"
        puts CLEAR
        quit = true
    when "Price_Check"
        puts "Welcome to Price Check"
    when "Compare_Cryptos"
        puts "Welcome to Compare Cryptos"
    when "My_Portfolio"
        puts "Welcome to My Portfolio"
    end
end
