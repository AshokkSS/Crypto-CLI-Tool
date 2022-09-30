require_relative '../config/environment'
require_relative '../lib/models/Main_Menu.rb'

menu = MainMenu.new
menu.startup
while !menu.quit_loop
    menu.display_main_menu
end
