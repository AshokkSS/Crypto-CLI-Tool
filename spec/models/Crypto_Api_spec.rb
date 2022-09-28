require_relative '../../lib/models/Crypto_Api.rb'
require 'net/http'
require_relative '../spec_helper.rb'
require_relative '../../config/environment'

RSpec.describe CryptoAPI do
    describe '#ping_api' do
        it 'On successful ping should set connection status hash object message to "Connected to API"' do
            allow(Net::HTTP).to receive(:get_response).and_return(Net::HTTPSuccess.new(1.0,'200','OK'))
            crypto_api = CryptoAPI.new
            crypto_api.ping_api
            expect(crypto_api.connection_status[:message]).to eq("Connected to API")
        end
        it 'Should show Failure for a failed ping' do
        
        end
    end
end