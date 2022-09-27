require_relative '../config/environment'
require_relative '../lib/run'

menu = Main_Menu.new
menu.startup
while !$quit
    menu.display_main_menu
end
# loading_menu
#display_main_menu
