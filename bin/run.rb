require_relative '../config/environment'
require_relative '../lib/run'

loading_menu
quit = nil
option_quit = nil
show_logo
while !quit
    prompt = TTY::Prompt.new
    options =  %w(Price_Check Compare_Cryptos My_Portfolio Close)
    exit_options =  %w(Input_Another Close)
    result = prompt.select("Please select an option below.", options, filter: true)
    case result
    when "Close"
        puts CLEAR
        quit = true
    when "Price_Check"
        option_quit = nil
        puts CLEAR
            while !option_quit
                show_logo
                puts "Here you can enter the Crypto you would like to view:"
                input = gets.chomp
                option_result = prompt.select("Please select an option below.", exit_options, filter: true)
                case option_result
                when "Input_Another"
                    puts CLEAR
                when "Close"
                    option_quit = true
                    puts CLEAR
                    show_logo
                end
            end
    when "Compare_Cryptos"
        puts "Welcome to Compare Cryptos"
    when "My_Portfolio"
        puts "Welcome to My Portfolio"
    end
end
