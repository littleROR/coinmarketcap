require "spec_helper"
require "pry"

describe Coinmarketcap do
  it "has a version number" do
    expect(Coinmarketcap::VERSION).not_to be nil
  end

  describe "#coins" do
    context 'without limit' do
      it "should receive a 200 and return coins" do
        VCR.use_cassette('all_coin_response') do
          coins = Coinmarketcap.coins
          expect(coins.count).to be > 0
        end
      end
    end

    context 'with limit as 10' do
      it "should receive a 200 and return 10 coins" do
        VCR.use_cassette('limit_coin_response') do
          coins = Coinmarketcap.coins(limit = 10)
          expect(coins.count).to eq(10)
        end
      end
    end
  end

  describe "#coin" do
    context 'with valid id' do
      it "should receive a 200 response with coin details" do
        VCR.use_cassette('single_coin_response') do
          coin = Coinmarketcap.coin('bitcoin')
          expect(coin).to be_a(Coinmarketcap::Coin)
          expect(coin.id).to eq('bitcoin')
        end
      end
    end

    context 'with invalid id' do
      it "should receive a 404 and return empty response" do
        VCR.use_cassette('wrong_coin_response') do
          coin = Coinmarketcap.coin('random')
          expect(coin).to be_a(Coinmarketcap::Coin)
          expect(coin.id).to be_nil
        end
      end
    end
  end

  describe "#global" do
    it "should receive a 200 response with global details" do
      VCR.use_cassette('global_coin_response') do
        global = Coinmarketcap.global
        expect(global.active_assets).to be > 0
      end
    end

    context 'with valid currency code' do
      it "should receive a 200 response with global details in that currency" do
        VCR.use_cassette('global_eur_coin_response') do
          global = Coinmarketcap.global('EUR')
          expect(global.total_market_cap_eur).to be > 0
        end
      end
    end
  end
end
