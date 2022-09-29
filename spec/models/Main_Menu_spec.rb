require_relative '../../lib/models/Main_Menu.rb'
require_relative '../spec_helper.rb'
require_relative '../../config/environment'

RSpec.describe MainMenu do
    describe '#get_user_input' do
        main_menu = MainMenu.new
        it 'on user input "Price_Check" should display "Welcome to Price Check!"' do
            expect{main_menu.get_user_input('Price_Check')}.to output(/Welcome to Price Check!/).to_stdout
        end
        it 'on user input "Compare_Crypto" should display "Welcome to Compare Crypto!"' do
            expect{main_menu.get_user_input('Compare_Cryptos')}.to output(/Welcome to Compare Crypto!/).to_stdout
        end
        it 'on user input "My_Portfolio" should display "Welcome to My Portfolio!"' do
            expect{main_menu.get_user_input('My_Portfolio')}.to output(/Welcome to My Portfolio!/).to_stdout
        end
        it 'on user input "Close" main menu quit loop should be true' do
            main_menu.get_user_input('Close')
            expect(main_menu.quit_loop).to eq(true)
        end
    end
end
