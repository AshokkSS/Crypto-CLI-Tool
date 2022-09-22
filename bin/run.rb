require_relative '../config/environment'
require_relative '../lib/run'

loading_menu
quit = nil
while !quit
    prompt = TTY::Prompt.new
    result = prompt.select("Choose your destiny?", %w(Scorpion Kano Jax))
    puts result
end
