module Coinmarketcap
  class GlobalData

    def []=(*options)
      key, value = options
      self.instance_variable_set("@#{key}", value)
    end
  end
end