class TopStockMovers::Viewing_options  ####take out
  attr_accessor :name, :desc, :sorter

  @@all = []

  def self.all
    @@all
  end

  viewing_options = [["Gainers", "Stocks that have increased the most in price", "percent_change-pos"], ["Losers", "Stocks that have lost most of their value", "percent_change-neg"], ["Active" , "Stocks that have been traded the most", "volume"],  ["Most-Volatile", "The fluctuation of price in any given timeframe", "percent_change-abs"],  ["Overbought", "Stocks that significantly increased in price due a large demand", "rating"], ["Oversold", "Stock prices have decreased substantially", "rating"], ["Large-Cap", "Largest companies by market cap", "market_cap"]]

  viewing_options.each do |array|
    option = self.new
      option.name = array[0]
      option.desc = array[1]
      option.sorter = array[2]
      @@all << option
  end
end
