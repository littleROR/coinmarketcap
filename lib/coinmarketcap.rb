require 'coinmarketcap/version'
require 'coinmarketcap/coin'
require 'coinmarketcap/global_data'
require 'rest-client'
require 'json'

module Coinmarketcap

  BASE_URL = "https://api.coinmarketcap.com/v1".freeze
  def self.coins(limit = nil)
    if limit.nil?
      response = RestClient.get("#{BASE_URL}/ticker/")
    else
      response = RestClient.get("#{BASE_URL}/ticker/?limit=#{limit}")
    end

    if response.code >= 200 && response.code < 300
      JSON.parse(response.body, object_class: Coin)
    end
  end

  def self.coin(id)
    response = RestClient.get("#{BASE_URL}/ticker/#{id}/")

    if response.code >= 200 && response.code < 300
      Array(JSON.parse(response.body, object_class: Coin)).first
    end

  rescue RestClient::NotFound
    return Coin.new
  end

  def self.global(currency = 'USD')
    url = "#{BASE_URL}/global/?convert=#{currency}"
    response = RestClient.get(url)

    if response.code >= 200 && response.code < 300
      Array(JSON.parse(response.body, object_class: GlobalData)).first
    end
  end

end
