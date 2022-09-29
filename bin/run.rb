require_relative '../config/environment'
require_relative '../lib/models/Main_Menu.rb'

menu = Main_Menu.new
menu.startup
while !$quit
    menu.display_main_menu
end