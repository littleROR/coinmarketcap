module Coinmarketcap
  class Coin
    attr_reader :percent_change_1h, :percent_change_24h, :percent_change_7d, :last_updated, :id,
                :name, :symbol, :rank, :price_usd, :price_btc, :"volume_24h_usd",
                :market_cap_usd, :available_supply, :total_suppl

    def []=(*options)
      key, value = options
      key = 'volume_24h_usd' if key == '24h_volume_usd'
      self.instance_variable_set("@#{key}", value)
    end
  end
end