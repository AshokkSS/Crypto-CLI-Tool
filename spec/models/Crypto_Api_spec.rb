require_relative '../../lib/models/Crypto_Api.rb'
require 'net/http'
require_relative '../spec_helper.rb'
require_relative '../../config/environment'

RSpec.describe CryptoAPI do
    describe '#ping_api' do
        crypto_api = CryptoAPI.new
        it 'On successful ping should set connection status hash object message to "Connected to API"' do
            allow(Net::HTTP).to receive(:get_response).and_return(Net::HTTPSuccess.new(1.0,'200','OK'))
            crypto_api.ping_api
            expect(crypto_api.connection_status[:message]).to eq("Connected to API")
        end
        it 'On bad_request ping should set connection status hash object message to "Unable to connect to API, Please close and reopen."' do
            allow(Net::HTTP).to receive(:get_response).and_return(Net::HTTPResponse.new(1.0,'400','bad_request'))
            crypto_api.ping_api
            expect(crypto_api.connection_status[:message]).to eq("Unable to connect to API, Please close and reopen.")
        end
    end
end