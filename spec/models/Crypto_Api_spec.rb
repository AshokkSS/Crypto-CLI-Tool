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
            expect(crypto_api.get_crypto_price('01coin','gbp')).to eq('01coin','gbp',0.00021159,'0.0','1.0316177973047886',0.0011973487654536286)
        end
        it 'On successful ping get_historical_data should set get_historical_data array with values' do
            response = Net::HTTPSuccess.new(1.0, '200', 'OK')
            expect_any_instance_of(Net::HTTP).to receive(:request) { response }
            expect(response).to receive(:body) { '{
                "prices": [
                  [
                    1663891200000,
                    17286.16763570644
                  ],
                  [
                    1663977600000,
                    17766.64822496067
                  ],
                  [
                    1664064000000,
                    17442.538626463895
                  ],
                  [
                    1664150400000,
                    17409.445755314355
                  ],
                  [
                    1664236800000,
                    17886.301506690168
                  ],
                  [
                    1664323200000,
                    17830.39467986055
                  ],
                  [
                    1664409600000,
                    17941.78345578764
                  ],
                  [
                    1664496000000,
                    17507.711262099965
                  ],
                  [
                    1664582400000,
                    17468.095863818824
                  ],
                  [
                    1664668800000,
                    17322.38934971689
                  ],
                  [
                    1664755200000,
                    17125.751063064978
                  ],
                  [
                    1664841600000,
                    17312.462839465927
                  ],
                  [
                    1664928000000,
                    17764.48299083846
                  ],
                  [
                    1665014400000,
                    17761.08079633631
                  ],
                  [
                    1665062396000,
                    17945.008223313882
                  ]
                ]}' } 
            crypto_api.get_historical_data('bitcoin','gbp')
            expect(crypto_api.price_check_historical).to contain_exactly(17286.16763570644,17507.711262099965)
        end
    end
end