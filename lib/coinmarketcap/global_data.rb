module Coinmarketcap
  class GlobalData

    attr_reader :total_market_cap_usd, :total_24h_volume_usd, :bitcoin_percentage_of_market_cap,
                :active_currencies, :active_assets, :active_markets

    def []=(*options)
      key, value = options
      self.instance_variable_set("@#{key}", value)
    end

    def method_missing(method_name)
      super unless method_name.to_s =~ /total_market_cap/
      self.instance_variable_get("@#{method_name}")
    end
  end
end
