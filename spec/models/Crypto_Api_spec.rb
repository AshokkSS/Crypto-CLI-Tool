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
        it 'On successful ping get_valid_coins should set valid_coins with list of valid coins filtered by id' do
            response = Net::HTTPSuccess.new(1.0, '200', 'OK')
            expect_any_instance_of(Net::HTTP).to receive(:request) { response }
            expect(response).to receive(:body) { '[
                {
                  "id": "01coin",
                  "symbol": "zoc",
                  "name": "01coin"
                }]' } 
            crypto_api.get_valid_coins
            expect(crypto_api.valid_coins).to contain_exactly('01coin')
        end
        it 'On successful ping get_valid_currencies should set valid_currencies with list of valid currencies' do
            response = Net::HTTPSuccess.new(1.0, '200', 'OK')
            expect_any_instance_of(Net::HTTP).to receive(:request) { response }
            expect(response).to receive(:body) { '["btc","eth","ltc"]' } 
            crypto_api.get_valid_currencies
            expect(crypto_api.valid_currencies).to contain_exactly('btc','eth','ltc')
        end
        it 'On successful ping get_crypto_price should set price_check_values array with values' do
            response = Net::HTTPSuccess.new(1.0, '200', 'OK')
            expect_any_instance_of(Net::HTTP).to receive(:request) { response }
            expect(response).to receive(:body) { '{"01coin":{"gbp":0.00021159,"gbp_market_cap":0.0,"gbp_24h_vol":1.0316177973047886,"gbp_24h_change":0.0011973487654536286}}' } 
            crypto_api.get_crypto_price('01coin','gbp')
            expect(crypto_api.price_check_values).to contain_exactly('01coin','gbp',0.00021159,'0.0','1.0316177973047886',0.0011973487654536286)
        end
    end
end