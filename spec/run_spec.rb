require_relative '../lib/run.rb'
require_relative './spec_helper.rb'
require_relative '../config/environment'



describe "#display_main_menu" do
  # expect{display_main_menu}.to eq('my message').to_stdout
  printed = capture_stdout do
      display_main_menu
    end
    it 'displays menu options' do
      expect(printed).to include("my message")
  end
end
# context "#display_main_menu" do
#   it 'should print "my message"' do
#     printed = capture_stdout do
#       display_main_menu # do your actual method call
#     end

#     printed.should eq("my message")
#   end
# end