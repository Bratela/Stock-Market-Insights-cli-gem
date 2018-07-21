class TopStockMovers::Stocks
  attr_accessor :category, :ticker_symbol, :name, :price, :percent_change, :change, :rating, :sector, :url, :volume, :market_cap

  @@all = []

  def initialize
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find_by_category(category)
    @@all.select {|stock| stock.category == category}
  end
end
