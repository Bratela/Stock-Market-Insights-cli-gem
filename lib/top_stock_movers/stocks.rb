class TopStockMovers::Stocks
  attr_accessor :ticker_symbol, :name, :price, :percent_change, :change, :rating, :sector, :url

  @@all = []

  def self.all
    @@all
  end

  def self.scrape_tradingview
    doc = Nokogiri::HTML(open("https://www.tradingview.com/markets/stocks-usa/market-movers-gainers/"))

    doc.css('body div div#js-category-content div div div div#js-screener-container div table tbody tr').each do |row|

      stock = self.new
      stock.url = "https://www.tradingview.com#{row.css('a').attr('href').value}"

      stock_info = row.css('td').collect{|td| td.text}

      stock.ticker_symbol = stock_info[0].split("\n\t\t\t\t\t\t").reject{|c| c.empty?}[0]
      stock.name = stock_info[0].split("\n\t\t\t\t\t\t").reject{|c| c.empty?}[1]
      stock.price = "$#{stock_info[1]}"
      stock.percent_change = stock_info[2]
      stock.change = stock_info[3]
      stock.rating = stock_info[4]
      stock.sector = stock_info[10]
      @@all << stock
    end





  end

end
